import 'dart:developer';
import 'dart:ffi';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'core/database/app_database.dart';
import 'core/security/secure_storage.dart';
import 'core/ai/background_agent.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Global Error Handling
  FlutterError.onError = (details) {
    log('Flutter Error:', error: details.exception, stackTrace: details.stack);
  };

  PlatformDispatcher.instance.onError = (error, stack) {
    log('Platform Error:', error: error, stackTrace: stack);
    return true;
  };

  // Diagnostic Logging for Native Libraries
  log('--- Runtime Diagnostics ---');
  log('OS: ${Platform.operatingSystem} ${Platform.operatingSystemVersion}');
  log('ABI: ${Abi.current()}');

  try {
    log('Attempting manual libsqlite3.so load...');
    DynamicLibrary.open('libsqlite3.so');
    log('SUCCESS: libsqlite3.so loaded via FFI');
  } catch (e) {
    log('FAILURE: libsqlite3.so could not be loaded via FFI: $e');
  }

  // Initialize Secure Storage
  final secureStorage = SecureStorage();
  try {
    log('Initializing SecureStorage...');
    await secureStorage.init();
    log('SecureStorage initialized');
  } catch (e) {
    log('SecureStorage initialization failed: $e');
  }

  // Initialize Local Database
  log('Initializing AppDatabase...');
  final database = AppDatabase();
  try {
    // Attempt a dummy query to force connection & library initialization
    await database.customSelect('SELECT 1').getSingle();
    log('Database connection verified successfully');
  } catch (e, stack) {
    log('CRITICAL: Database initialization error: $e');
    log('Stack trace: $stack');
  }

  // Initialize Background Agent
  try {
    log('Initializing BackgroundAgent...');
    await BackgroundAgent.init();
    await BackgroundAgent.startService();
    log('BackgroundAgent initialized');
  } catch (e) {
    log('BackgroundAgent init failed: $e');
  }

  runApp(BabyStepsApp(database: database, secureStorage: secureStorage));
}
