import 'package:drift/drift.dart';
import '../app_database.dart';
import '../../security/secure_storage.dart';

class BabyModel {
  BabyModel({
    required this.id,
    required this.name,
    required this.dateOfBirth,
    this.gender,
    this.remoteFolderId,
  });

  final int id;
  final String name;
  final DateTime dateOfBirth;
  final String? gender;
  final String? remoteFolderId;
}

class BabyRepository {
  BabyRepository(this._db, this._secureStorage);

  final AppDatabase _db;
  final SecureStorage _secureStorage;

  Future<BabyModel> _decryptBaby(Baby baby) async {
    final futures = <Future<String?>>[
      _secureStorage.decryptData(baby.encryptedName),
      _secureStorage.decryptData(baby.encryptedDateOfBirth),
    ];
    if (baby.encryptedGender != null) {
      futures.add(_secureStorage.decryptData(baby.encryptedGender!));
    } else {
      futures.add(Future.value(null));
    }
    
    final results = await Future.wait(futures);
    final name = results[0] as String;
    final dobString = results[1] as String;
    final gender = results[2];

    return BabyModel(
      id: baby.id,
      name: name,
      dateOfBirth: DateTime.parse(dobString),
      gender: gender,
      remoteFolderId: baby.remoteFolderId,
    );
  }

  Future<int> addBaby(String name, DateTime dateOfBirth, String? gender) {
    final encryptedName = _secureStorage.encryptData(name);
    final encryptedDob = _secureStorage.encryptData(dateOfBirth.toIso8601String());
    final encryptedGender = gender != null ? _secureStorage.encryptData(gender) : null;

    return _db.into(_db.babies).insert(BabiesCompanion.insert(
      encryptedName: encryptedName,
      encryptedDateOfBirth: encryptedDob,
      encryptedGender: Value(encryptedGender),
    ));
  }

  Future<int> joinBaby({
    required String name,
    required DateTime dateOfBirth,
    required String? gender,
    required String remoteFolderId,
    required String encryptionKey,
  }) async {
    // Note: encryptionKey is handled by SecureStorage when saved, 
    // but here we just need to register the baby profile.
    final encryptedName = _secureStorage.encryptData(name);
    final encryptedDob = _secureStorage.encryptData(dateOfBirth.toIso8601String());
    final encryptedGender = gender != null ? _secureStorage.encryptData(gender) : null;

    return _db.into(_db.babies).insert(BabiesCompanion.insert(
      encryptedName: encryptedName,
      encryptedDateOfBirth: encryptedDob,
      encryptedGender: Value(encryptedGender),
      remoteFolderId: Value(remoteFolderId),
    ));
  }

  Future<void> updateRemoteFolderId(int babyId, String folderId) {
    return (_db.update(_db.babies)..where((t) => t.id.equals(babyId))).write(
      BabiesCompanion(remoteFolderId: Value(folderId)),
    );
  }

  Future<List<BabyModel>> getAllBabies() async {
    final babies = await _db.select(_db.babies).get();
    final decryptedBabies = await Future.wait(
      babies.map(_decryptBaby),
    );
    return decryptedBabies;
  }

  Future<BabyModel?> getBabyById(int id) async {
    final query = _db.select(_db.babies)..where((t) => t.id.equals(id));
    final baby = await query.getSingleOrNull();
    if (baby != null) {
      return _decryptBaby(baby);
    }
    return null;
  }

  Future<bool> updateBaby(int id, String name, DateTime dateOfBirth, String? gender) {
    final encryptedName = _secureStorage.encryptData(name);
    final encryptedDob = _secureStorage.encryptData(dateOfBirth.toIso8601String());
    final encryptedGender = gender != null ? _secureStorage.encryptData(gender) : null;

    return (_db.update(_db.babies)..where((t) => t.id.equals(id))).write(
      BabiesCompanion(
        encryptedName: Value(encryptedName),
        encryptedDateOfBirth: Value(encryptedDob),
        encryptedGender: Value(encryptedGender),
      ),
    ).then((rows) => rows > 0);
  }

  Future<int> deleteBaby(int id) {
    return (_db.delete(_db.babies)..where((t) => t.id.equals(id))).go();
  }
}
