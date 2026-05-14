import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'dart:convert';

class SecureStorage {
  SecureStorage() : _storage = const FlutterSecureStorage();

  final FlutterSecureStorage _storage;
  encrypt.Encrypter? _encrypter;
  // No longer store a single IV - generate unique IV per encryption

  Future<void> init() async {
    const androidOptions = AndroidOptions();

    try {
      await _initInternal(androidOptions);
    } catch (e) {
      // Common issue on Android (especially high-end Samsung devices): 
      // Keystore corruption or SecurityException.
      // Recovery: Clear storage and retry once.
      try {
        await _storage.deleteAll(aOptions: androidOptions);
        await _initInternal(androidOptions);
      } catch (retryError) {
        throw Exception('SecureStorage critical failure: $retryError');
      }
    }
  }

  Future<void> _initInternal(AndroidOptions androidOptions) async {
    // Generate or retrieve encryption key only (no static IV)
    final String? keyString = await _storage.read(
      key: 'encryption_key',
      aOptions: androidOptions,
    );

    if (keyString == null) {
      final key = encrypt.Key.fromSecureRandom(32);
      await _storage.write(
        key: 'encryption_key',
        value: base64Encode(key.bytes),
        aOptions: androidOptions,
      );
      _encrypter = encrypt.Encrypter(
        encrypt.AES(key, mode: encrypt.AESMode.gcm),
      );
    } else {
      final key = encrypt.Key(base64Decode(keyString));
      _encrypter = encrypt.Encrypter(
        encrypt.AES(key, mode: encrypt.AESMode.gcm),
      );
    }
  }

  /// Encrypts data with a unique random IV for each encryption.
  /// Returns a string in format: base64(iv):base64(ciphertext):base64(authTag)
  String encryptData(String plainText) {
    if (_encrypter == null) {
      throw Exception('SecureStorage not initialized');
    }
    
    // Generate unique random IV for each encryption
    final iv = encrypt.IV.fromSecureRandom(16);
    
    // Encrypt with the unique IV
    final encrypted = _encrypter!.encrypt(plainText, iv: iv);
    
    // Return IV and ciphertext concatenated with delimiter
    // Format: base64(iv):base64(ciphertext)
    // Note: In AES-GCM, the authTag is part of the encrypted object
    return '${base64Encode(iv.bytes)}:${encrypted.base64}';
  }

  /// Decrypts data that was encrypted with encryptData.
  /// Expects format: base64(iv):base64(ciphertext)
  Future<String> decryptData(String encryptedData) async {
    if (_encrypter == null) {
      throw Exception('SecureStorage not initialized');
    }
    
    try {
      // Split the encrypted data into IV and ciphertext
      final parts = encryptedData.split(':');
      if (parts.length != 2) {
        // Try to handle legacy format (ciphertext only) for backward compatibility
        // This assumes old data was encrypted with static IV stored in secure storage
        return await _decryptLegacy(encryptedData);
      }
      
      final iv = encrypt.IV(base64Decode(parts[0]));
      final ciphertext = parts[1];
      
      return _encrypter!.decrypt64(ciphertext, iv: iv);
    } catch (e) {
      // If new format fails, try legacy decryption
      return await _decryptLegacy(encryptedData);
    }
  }
  
  /// Legacy decryption for backward compatibility with old data
  /// This uses the old static IV stored in secure storage
  Future<String> _decryptLegacy(String ciphertext) async {
    if (_encrypter == null) {
      throw Exception('SecureStorage not initialized');
    }
    
    // Try to retrieve old IV from storage for backward compatibility
    final ivString = await _storage.read(key: 'encryption_iv');
    if (ivString == null) {
      throw Exception('Cannot decrypt legacy data: old IV not found');
    }
    
    final oldIv = encrypt.IV(base64Decode(ivString));
    
    try {
      return _encrypter!.decrypt64(ciphertext, iv: oldIv);
    } catch (e) {
      throw Exception('Legacy decryption failed: $e');
    }
  }
  
  /// Migrates old encrypted data to new format
  /// This would be called during app update to migrate existing data
  Future<String> migrateLegacyData(String legacyCiphertext) async {
    if (_encrypter == null) {
      throw Exception('SecureStorage not initialized');
    }
    
    // For migration, we need the old IV from storage
    final ivString = await _storage.read(key: 'encryption_iv');
    if (ivString == null) {
      throw Exception('Cannot migrate: old IV not found');
    }
    
    final oldIv = encrypt.IV(base64Decode(ivString));
    
    try {
      // Decrypt with old IV
      final plaintext = _encrypter!.decrypt64(legacyCiphertext, iv: oldIv);
      // Re-encrypt with new format (unique IV)
      return encryptData(plaintext);
    } catch (e) {
      throw Exception('Migration failed: $e');
    }
  }
  Future<String> getEncryptionKey() async {
    const androidOptions = AndroidOptions();
    final key = await _storage.read(
      key: 'encryption_key',
      aOptions: androidOptions,
    );
    if (key == null) throw Exception('Encryption key not found');
    return key;
  }
}
