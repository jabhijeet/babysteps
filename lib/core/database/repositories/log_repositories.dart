import 'package:drift/drift.dart';
import '../app_database.dart';
import '../../security/secure_storage.dart';

class FeedingLogRepository {
  FeedingLogRepository(this._db, this._secureStorage);

  final AppDatabase _db;
  final SecureStorage _secureStorage;

  Future<int> addFeedingLog({
    required int babyId,
    required String type,
    required DateTime startTime,
    DateTime? endTime,
    double? volumeAmount,
    String? volumeUnit,
    String? breastSide,
    int? leftDurationSeconds,
    int? rightDurationSeconds,
    String? formulaBrand,
    double? formulaTemp,
    String? solidFoodReaction,
    String? solidFoodReactionPhotoPath,
    String? notes,
  }) {
    final encryptedNotes = notes != null ? _secureStorage.encryptData(notes) : null;

    return _db.into(_db.feedingLogs).insert(FeedingLogsCompanion.insert(
      babyId: babyId,
      type: type,
      startTime: startTime,
      endTime: Value(endTime),
      volumeAmount: Value(volumeAmount),
      volumeUnit: Value(volumeUnit),
      breastSide: Value(breastSide),
      leftDurationSeconds: Value(leftDurationSeconds),
      rightDurationSeconds: Value(rightDurationSeconds),
      formulaBrand: Value(formulaBrand),
      formulaTemp: Value(formulaTemp),
      solidFoodReaction: Value(solidFoodReaction),
      solidFoodReactionPhotoPath: Value(solidFoodReactionPhotoPath),
      notes: Value(encryptedNotes),
    ));
  }

  Future<List<FeedingLog>> getFeedingLogs(int babyId) async {
    final query = _db.select(_db.feedingLogs)
      ..where((tbl) => tbl.babyId.equals(babyId))
      ..orderBy([(t) => OrderingTerm(expression: t.startTime, mode: OrderingMode.desc)]);
    final logs = await query.get();
    final decryptedLogs = await Future.wait(logs.map((log) async {
      final decryptedNotes = log.notes != null ? await _secureStorage.decryptData(log.notes!) : null;
      return log.copyWith(notes: Value(decryptedNotes));
    }));
    return decryptedLogs;
  }

  Future<List<FeedingLog>> getFeedingLogsForBaby(int babyId, {DateTime? startDate, DateTime? endDate}) async {
    final query = _db.select(_db.feedingLogs)
      ..where((tbl) => tbl.babyId.equals(babyId));
    
    if (startDate != null) {
      query.where((tbl) => tbl.startTime.isBiggerOrEqualValue(startDate));
    }
    if (endDate != null) {
      query.where((tbl) => tbl.startTime.isSmallerOrEqualValue(endDate));
    }
    
    query.orderBy([(t) => OrderingTerm(expression: t.startTime, mode: OrderingMode.asc)]);
    
    final logs = await query.get();
    final decryptedLogs = await Future.wait(logs.map((log) async {
      final decryptedNotes = log.notes != null ? await _secureStorage.decryptData(log.notes!) : null;
      return log.copyWith(notes: Value(decryptedNotes));
    }));
    return decryptedLogs;
  }

  Stream<FeedingLog?> watchLatestFeedingLog(int babyId) {
    return (_db.select(_db.feedingLogs)
          ..where((tbl) => tbl.babyId.equals(babyId))
          ..orderBy([(t) => OrderingTerm(expression: t.startTime, mode: OrderingMode.desc)])
          ..limit(1))
        .watchSingleOrNull()
        .asyncMap((log) async {
      if (log != null) {
        final decryptedNotes = log.notes != null ? await _secureStorage.decryptData(log.notes!) : null;
        return log.copyWith(notes: Value(decryptedNotes));
      }
      return null;
    });
  }

  Stream<List<FeedingLog>> watchFeedingLogs(int babyId) {
    return (_db.select(_db.feedingLogs)
          ..where((tbl) => tbl.babyId.equals(babyId))
          ..orderBy([(t) => OrderingTerm(expression: t.startTime, mode: OrderingMode.desc)]))
        .watch()
        .asyncMap((logs) async {
      final decryptedLogs = await Future.wait(logs.map((log) async {
        final decryptedNotes = log.notes != null ? await _secureStorage.decryptData(log.notes!) : null;
        return log.copyWith(notes: Value(decryptedNotes));
      }));
      return decryptedLogs;
    });
  }

  Future<void> deleteFeedingLog(int id) {
    return (_db.delete(_db.feedingLogs)..where((tbl) => tbl.id.equals(id))).go();
  }

  Future<bool> updateFeedingLog(FeedingLog log) {
    final encryptedNotes = log.notes != null ? _secureStorage.encryptData(log.notes!) : null;
    final updatedLog = encryptedNotes != null ? log.copyWith(notes: Value(encryptedNotes)) : log;
    return (_db.update(_db.feedingLogs)..where((t) => t.id.equals(log.id)))
        .write(updatedLog.toCompanion(true))
        .then((count) => count > 0);
  }
}

class SleepLogRepository {
  SleepLogRepository(this._db, this._secureStorage);

  final AppDatabase _db;
  final SecureStorage _secureStorage;

  Future<int> addSleepLog({
    required int babyId,
    required DateTime startTime,
    DateTime? endTime,
    String? notes,
  }) {
    final encryptedNotes = notes != null ? _secureStorage.encryptData(notes) : null;
    return _db.into(_db.sleepLogs).insert(SleepLogsCompanion.insert(
      babyId: babyId,
      startTime: startTime,
      endTime: Value(endTime),
      notes: Value(encryptedNotes),
    ));
  }
  
  Future<List<SleepLog>> getSleepLogs(int babyId) async {
    final query = _db.select(_db.sleepLogs)
      ..where((tbl) => tbl.babyId.equals(babyId))
      ..orderBy([(t) => OrderingTerm(expression: t.startTime, mode: OrderingMode.desc)]);
    final logs = await query.get();
    final decryptedLogs = await Future.wait(logs.map((log) async {
      final decryptedNotes = log.notes != null ? await _secureStorage.decryptData(log.notes!) : null;
      return log.copyWith(notes: Value(decryptedNotes));
    }));
    return decryptedLogs;
  }

  Future<List<SleepLog>> getSleepLogsForBaby(int babyId, {DateTime? startDate, DateTime? endDate}) async {
    final query = _db.select(_db.sleepLogs)
      ..where((tbl) => tbl.babyId.equals(babyId));
    
    if (startDate != null) {
      query.where((tbl) => tbl.startTime.isBiggerOrEqualValue(startDate));
    }
    if (endDate != null) {
      query.where((tbl) => tbl.startTime.isSmallerOrEqualValue(endDate));
    }
    
    query.orderBy([(t) => OrderingTerm(expression: t.startTime, mode: OrderingMode.asc)]);
    
    final logs = await query.get();
    final decryptedLogs = await Future.wait(logs.map((log) async {
      final decryptedNotes = log.notes != null ? await _secureStorage.decryptData(log.notes!) : null;
      return log.copyWith(notes: Value(decryptedNotes));
    }));
    return decryptedLogs;
  }

  Future<SleepLog?> getLatestSleepLog(int babyId) async {
    final query = _db.select(_db.sleepLogs)
      ..where((tbl) => tbl.babyId.equals(babyId))
      ..orderBy([(t) => OrderingTerm(expression: t.startTime, mode: OrderingMode.desc)])
      ..limit(1);
    final log = await query.getSingleOrNull();
    if (log != null) {
      final decryptedNotes = log.notes != null ? await _secureStorage.decryptData(log.notes!) : null;
      return log.copyWith(notes: Value(decryptedNotes));
    }
    return null;
  }

  Stream<SleepLog?> watchLatestSleepLog(int babyId) {
    return (_db.select(_db.sleepLogs)
          ..where((tbl) => tbl.babyId.equals(babyId))
          ..orderBy([(t) => OrderingTerm(expression: t.startTime, mode: OrderingMode.desc)])
          ..limit(1))
        .watchSingleOrNull()
        .asyncMap((log) async {
      if (log != null) {
        final decryptedNotes = log.notes != null ? await _secureStorage.decryptData(log.notes!) : null;
        return log.copyWith(notes: Value(decryptedNotes));
      }
      return null;
    });
  }

  Stream<List<SleepLog>> watchSleepLogs(int babyId) {
    return (_db.select(_db.sleepLogs)
          ..where((tbl) => tbl.babyId.equals(babyId))
          ..orderBy([(t) => OrderingTerm(expression: t.startTime, mode: OrderingMode.desc)]))
        .watch()
        .asyncMap((logs) async {
      final decryptedLogs = await Future.wait(logs.map((log) async {
        final decryptedNotes = log.notes != null ? await _secureStorage.decryptData(log.notes!) : null;
        return log.copyWith(notes: Value(decryptedNotes));
      }));
      return decryptedLogs;
    });
  }

  Future<void> deleteSleepLog(int id) {
    return (_db.delete(_db.sleepLogs)..where((tbl) => tbl.id.equals(id))).go();
  }

  Future<bool> updateSleepLog(SleepLog log) {
    final encryptedNotes = log.notes != null ? _secureStorage.encryptData(log.notes!) : null;
    final updatedLog = encryptedNotes != null ? log.copyWith(notes: Value(encryptedNotes)) : log;
    return (_db.update(_db.sleepLogs)..where((t) => t.id.equals(log.id)))
        .write(updatedLog.toCompanion(true))
        .then((count) => count > 0);
  }
}

class DiaperLogRepository {
  DiaperLogRepository(this._db, this._secureStorage);

  final AppDatabase _db;
  final SecureStorage _secureStorage;

  Future<int> addDiaperLog({
    required int babyId,
    required DateTime startTime,
    DateTime? endTime,
    required String type,
    String? consistency,
    String? color,
    String? notes,
  }) {
    final encryptedNotes = notes != null ? _secureStorage.encryptData(notes) : null;
    return _db.into(_db.diaperLogs).insert(DiaperLogsCompanion.insert(
      babyId: babyId,
      startTime: startTime,
      endTime: Value(endTime),
      type: type,
      consistency: Value(consistency),
      color: Value(color),
      notes: Value(encryptedNotes),
    ));
  }
  
  Future<List<DiaperLog>> getDiaperLogs(int babyId) async {
    final query = _db.select(_db.diaperLogs)
      ..where((tbl) => tbl.babyId.equals(babyId))
      ..orderBy([(t) => OrderingTerm(expression: t.startTime, mode: OrderingMode.desc)]);
    final logs = await query.get();
    final decryptedLogs = await Future.wait(logs.map((log) async {
      final decryptedNotes = log.notes != null ? await _secureStorage.decryptData(log.notes!) : null;
      return log.copyWith(notes: Value(decryptedNotes));
    }));
    return decryptedLogs;
  }

  Future<List<DiaperLog>> getDiaperLogsForBaby(int babyId, {DateTime? startDate, DateTime? endDate}) async {
    final query = _db.select(_db.diaperLogs)
      ..where((tbl) => tbl.babyId.equals(babyId));
    
    if (startDate != null) {
      query.where((tbl) => tbl.startTime.isBiggerOrEqualValue(startDate));
    }
    if (endDate != null) {
      query.where((tbl) => tbl.startTime.isSmallerOrEqualValue(endDate));
    }
    
    query.orderBy([(t) => OrderingTerm(expression: t.startTime, mode: OrderingMode.asc)]);
    
    final logs = await query.get();
    final decryptedLogs = await Future.wait(logs.map((log) async {
      final decryptedNotes = log.notes != null ? await _secureStorage.decryptData(log.notes!) : null;
      return log.copyWith(notes: Value(decryptedNotes));
    }));
    return decryptedLogs;
  }

  Future<DiaperLog?> getLatestDiaperLog(int babyId) async {
    final query = _db.select(_db.diaperLogs)
      ..where((tbl) => tbl.babyId.equals(babyId))
      ..orderBy([(t) => OrderingTerm(expression: t.startTime, mode: OrderingMode.desc)])
      ..limit(1);
    final log = await query.getSingleOrNull();
    if (log != null) {
      final decryptedNotes = log.notes != null ? await _secureStorage.decryptData(log.notes!) : null;
      return log.copyWith(notes: Value(decryptedNotes));
    }
    return null;
  }

  Stream<DiaperLog?> watchLatestDiaperLog(int babyId) {
    return (_db.select(_db.diaperLogs)
          ..where((tbl) => tbl.babyId.equals(babyId))
          ..orderBy([(t) => OrderingTerm(expression: t.startTime, mode: OrderingMode.desc)])
          ..limit(1))
        .watchSingleOrNull()
        .asyncMap((log) async {
      if (log != null) {
        final decryptedNotes = log.notes != null ? await _secureStorage.decryptData(log.notes!) : null;
        return log.copyWith(notes: Value(decryptedNotes));
      }
      return null;
    });
  }

  Stream<List<DiaperLog>> watchDiaperLogs(int babyId) {
    return (_db.select(_db.diaperLogs)
          ..where((tbl) => tbl.babyId.equals(babyId))
          ..orderBy([(t) => OrderingTerm(expression: t.startTime, mode: OrderingMode.desc)]))
        .watch()
        .asyncMap((logs) async {
      final decryptedLogs = await Future.wait(logs.map((log) async {
        final decryptedNotes = log.notes != null ? await _secureStorage.decryptData(log.notes!) : null;
        return log.copyWith(notes: Value(decryptedNotes));
      }));
      return decryptedLogs;
    });
  }

  Future<void> deleteDiaperLog(int id) {
    return (_db.delete(_db.diaperLogs)..where((tbl) => tbl.id.equals(id))).go();
  }

  Future<bool> updateDiaperLog(DiaperLog log) {
    final encryptedNotes = log.notes != null ? _secureStorage.encryptData(log.notes!) : null;
    final updatedLog = encryptedNotes != null ? log.copyWith(notes: Value(encryptedNotes)) : log;
    return (_db.update(_db.diaperLogs)..where((t) => t.id.equals(log.id)))
        .write(updatedLog.toCompanion(true))
        .then((count) => count > 0);
  }
}

class GrowthLogRepository {
  GrowthLogRepository(this._db, this._secureStorage);

  final AppDatabase _db;
  final SecureStorage _secureStorage;

  Future<int> addGrowthLog({
    required int babyId,
    required DateTime startTime,
    DateTime? endTime,
    double? weight,
    double? height,
    double? headCircumference,
    String? notes,
  }) {
    final encryptedNotes = notes != null ? _secureStorage.encryptData(notes) : null;
    return _db.into(_db.growthLogs).insert(GrowthLogsCompanion.insert(
      babyId: babyId,
      startTime: startTime,
      endTime: Value(endTime),
      weight: Value(weight),
      height: Value(height),
      headCircumference: Value(headCircumference),
      notes: Value(encryptedNotes),
    ));
  }
  
  Future<List<GrowthLog>> getGrowthLogs(int babyId) async {
    final query = _db.select(_db.growthLogs)
      ..where((tbl) => tbl.babyId.equals(babyId))
      ..orderBy([(t) => OrderingTerm(expression: t.startTime, mode: OrderingMode.desc)]);
    final logs = await query.get();
    final decryptedLogs = await Future.wait(logs.map((log) async {
      final decryptedNotes = log.notes != null ? await _secureStorage.decryptData(log.notes!) : null;
      return log.copyWith(notes: Value(decryptedNotes));
    }));
    return decryptedLogs;
  }

  Future<List<GrowthLog>> getGrowthLogsForBaby(int babyId, {DateTime? startDate, DateTime? endDate}) async {
    final query = _db.select(_db.growthLogs)
      ..where((tbl) => tbl.babyId.equals(babyId));
    
    if (startDate != null) {
      query.where((tbl) => tbl.startTime.isBiggerOrEqualValue(startDate));
    }
    if (endDate != null) {
      query.where((tbl) => tbl.startTime.isSmallerOrEqualValue(endDate));
    }
    
    query.orderBy([(t) => OrderingTerm(expression: t.startTime, mode: OrderingMode.asc)]);
    
    final logs = await query.get();
    final decryptedLogs = await Future.wait(logs.map((log) async {
      final decryptedNotes = log.notes != null ? await _secureStorage.decryptData(log.notes!) : null;
      return log.copyWith(notes: Value(decryptedNotes));
    }));
    return decryptedLogs;
  }

  Future<GrowthLog?> getLatestGrowthLog(int babyId) async {
    final query = _db.select(_db.growthLogs)
      ..where((tbl) => tbl.babyId.equals(babyId))
      ..orderBy([(t) => OrderingTerm(expression: t.startTime, mode: OrderingMode.desc)])
      ..limit(1);
    final log = await query.getSingleOrNull();
    if (log != null) {
      final decryptedNotes = log.notes != null ? await _secureStorage.decryptData(log.notes!) : null;
      return log.copyWith(notes: Value(decryptedNotes));
    }
    return null;
  }

  Stream<List<GrowthLog>> watchGrowthLogs(int babyId) {
    return (_db.select(_db.growthLogs)
          ..where((tbl) => tbl.babyId.equals(babyId))
          ..orderBy([(t) => OrderingTerm(expression: t.startTime, mode: OrderingMode.desc)]))
        .watch()
        .asyncMap((logs) async {
      final decryptedLogs = await Future.wait(logs.map((log) async {
        final decryptedNotes = log.notes != null ? await _secureStorage.decryptData(log.notes!) : null;
        return log.copyWith(notes: Value(decryptedNotes));
      }));
      return decryptedLogs;
    });
  }

  Future<void> deleteGrowthLog(int id) {
    return (_db.delete(_db.growthLogs)..where((tbl) => tbl.id.equals(id))).go();
  }

  Future<bool> updateGrowthLog(GrowthLog log) {
    final encryptedNotes = log.notes != null ? _secureStorage.encryptData(log.notes!) : null;
    final updatedLog = encryptedNotes != null ? log.copyWith(notes: Value(encryptedNotes)) : log;
    
    // Using manual update with where clause for absolute row isolation
    return (_db.update(_db.growthLogs)..where((t) => t.id.equals(log.id)))
        .write(updatedLog.toCompanion(true))
        .then((count) => count > 0);
  }
}

class ActivityLogRepository {
  ActivityLogRepository(this._db, this._secureStorage);

  final AppDatabase _db;
  final SecureStorage _secureStorage;

  Future<int> addActivityLog({
    required int babyId,
    required String type,
    required DateTime startTime,
    DateTime? endTime,
    String? milestones,
    String? notes,
  }) {
    final encryptedNotes = notes != null ? _secureStorage.encryptData(notes) : null;
    return _db.into(_db.activityLogs).insert(ActivityLogsCompanion.insert(
      babyId: babyId,
      type: type,
      startTime: startTime,
      endTime: Value(endTime),
      milestones: Value(milestones),
      notes: Value(encryptedNotes),
    ));
  }
  
  Future<List<ActivityLog>> getActivityLogs(int babyId) async {
    final query = _db.select(_db.activityLogs)
      ..where((tbl) => tbl.babyId.equals(babyId))
      ..orderBy([(t) => OrderingTerm(expression: t.startTime, mode: OrderingMode.desc)]);
    final logs = await query.get();
    final decryptedLogs = await Future.wait(logs.map((log) async {
      final decryptedNotes = log.notes != null ? await _secureStorage.decryptData(log.notes!) : null;
      return log.copyWith(notes: Value(decryptedNotes));
    }));
    return decryptedLogs;
  }

  Future<List<ActivityLog>> getActivityLogsForBaby(int babyId, {DateTime? startDate, DateTime? endDate}) async {
    final query = _db.select(_db.activityLogs)
      ..where((tbl) => tbl.babyId.equals(babyId));
    
    if (startDate != null) {
      query.where((tbl) => tbl.startTime.isBiggerOrEqualValue(startDate));
    }
    if (endDate != null) {
      query.where((tbl) => tbl.startTime.isSmallerOrEqualValue(endDate));
    }
    
    query.orderBy([(t) => OrderingTerm(expression: t.startTime, mode: OrderingMode.asc)]);
    
    final logs = await query.get();
    final decryptedLogs = await Future.wait(logs.map((log) async {
      final decryptedNotes = log.notes != null ? await _secureStorage.decryptData(log.notes!) : null;
      return log.copyWith(notes: Value(decryptedNotes));
    }));
    return decryptedLogs;
  }

  Future<ActivityLog?> getLatestActivityLog(int babyId) async {
    final query = _db.select(_db.activityLogs)
      ..where((tbl) => tbl.babyId.equals(babyId))
      ..orderBy([(t) => OrderingTerm(expression: t.startTime, mode: OrderingMode.desc)])
      ..limit(1);
    final log = await query.getSingleOrNull();
    if (log != null) {
      final decryptedNotes = log.notes != null ? await _secureStorage.decryptData(log.notes!) : null;
      return log.copyWith(notes: Value(decryptedNotes));
    }
    return null;
  }

  Stream<List<ActivityLog>> watchActivityLogs(int babyId) {
    return (_db.select(_db.activityLogs)
          ..where((tbl) => tbl.babyId.equals(babyId))
          ..orderBy([(t) => OrderingTerm(expression: t.startTime, mode: OrderingMode.desc)]))
        .watch()
        .asyncMap((logs) async {
      final decryptedLogs = await Future.wait(logs.map((log) async {
        final decryptedNotes = log.notes != null ? await _secureStorage.decryptData(log.notes!) : null;
        return log.copyWith(notes: Value(decryptedNotes));
      }));
      return decryptedLogs;
    });
  }

  Future<void> deleteActivityLog(int id) {
    return (_db.delete(_db.activityLogs)..where((tbl) => tbl.id.equals(id))).go();
  }

  Future<bool> updateActivityLog(ActivityLog log) {
    final encryptedNotes = log.notes != null ? _secureStorage.encryptData(log.notes!) : null;
    final updatedLog = encryptedNotes != null ? log.copyWith(notes: Value(encryptedNotes)) : log;
    return (_db.update(_db.activityLogs)..where((t) => t.id.equals(log.id)))
        .write(updatedLog.toCompanion(true))
        .then((count) => count > 0);
  }
}

class MedicalLogRepository {
  MedicalLogRepository(this._db, this._secureStorage);

  final AppDatabase _db;
  final SecureStorage _secureStorage;

  Future<int> addMedicalLog({
    required int babyId,
    required String type,
    required String name,
    String? dosage,
    required DateTime startTime,
    DateTime? endTime,
    DateTime? reminderTime,
    String? notes,
  }) {
    final encryptedNotes = notes != null ? _secureStorage.encryptData(notes) : null;
    return _db.into(_db.medicalLogs).insert(MedicalLogsCompanion.insert(
      babyId: babyId,
      type: type,
      name: name,
      dosage: Value(dosage),
      startTime: startTime,
      endTime: Value(endTime),
      reminderTime: Value(reminderTime),
      notes: Value(encryptedNotes),
    ));
  }
  
  Future<List<MedicalLog>> getMedicalLogs(int babyId) async {
    final query = _db.select(_db.medicalLogs)
      ..where((tbl) => tbl.babyId.equals(babyId))
      ..orderBy([(t) => OrderingTerm(expression: t.startTime, mode: OrderingMode.desc)]);
    final logs = await query.get();
    final decryptedLogs = await Future.wait(logs.map((log) async {
      final decryptedNotes = log.notes != null ? await _secureStorage.decryptData(log.notes!) : null;
      return log.copyWith(notes: Value(decryptedNotes));
    }));
    return decryptedLogs;
  }

  Future<List<MedicalLog>> getMedicalLogsForBaby(int babyId, {DateTime? startDate, DateTime? endDate}) async {
    final query = _db.select(_db.medicalLogs)
      ..where((tbl) => tbl.babyId.equals(babyId));
    
    if (startDate != null) {
      query.where((tbl) => tbl.startTime.isBiggerOrEqualValue(startDate));
    }
    if (endDate != null) {
      query.where((tbl) => tbl.startTime.isSmallerOrEqualValue(endDate));
    }
    
    query.orderBy([(t) => OrderingTerm(expression: t.startTime, mode: OrderingMode.asc)]);
    
    final logs = await query.get();
    final decryptedLogs = await Future.wait(logs.map((log) async {
      final decryptedNotes = log.notes != null ? await _secureStorage.decryptData(log.notes!) : null;
      return log.copyWith(notes: Value(decryptedNotes));
    }));
    return decryptedLogs;
  }

  Future<MedicalLog?> getLatestMedicalLog(int babyId) async {
    final query = _db.select(_db.medicalLogs)
      ..where((tbl) => tbl.babyId.equals(babyId))
      ..orderBy([(t) => OrderingTerm(expression: t.startTime, mode: OrderingMode.desc)])
      ..limit(1);
    final log = await query.getSingleOrNull();
    if (log != null) {
      final decryptedNotes = log.notes != null ? await _secureStorage.decryptData(log.notes!) : null;
      return log.copyWith(notes: Value(decryptedNotes));
    }
    return null;
  }

  Stream<List<MedicalLog>> watchMedicalLogs(int babyId) {
    return (_db.select(_db.medicalLogs)
          ..where((tbl) => tbl.babyId.equals(babyId))
          ..orderBy([(t) => OrderingTerm(expression: t.startTime, mode: OrderingMode.desc)]))
        .watch()
        .asyncMap((logs) async {
      final decryptedLogs = await Future.wait(logs.map((log) async {
        final decryptedNotes = log.notes != null ? await _secureStorage.decryptData(log.notes!) : null;
        return log.copyWith(notes: Value(decryptedNotes));
      }));
      return decryptedLogs;
    });
  }

  Future<void> deleteMedicalLog(int id) {
    return (_db.delete(_db.medicalLogs)..where((tbl) => tbl.id.equals(id))).go();
  }

  Future<bool> updateMedicalLog(MedicalLog log) {
    final encryptedNotes = log.notes != null ? _secureStorage.encryptData(log.notes!) : null;
    final updatedLog = encryptedNotes != null ? log.copyWith(notes: Value(encryptedNotes)) : log;
    return (_db.update(_db.medicalLogs)..where((t) => t.id.equals(log.id)))
        .write(updatedLog.toCompanion(true))
        .then((count) => count > 0);
  }
}
