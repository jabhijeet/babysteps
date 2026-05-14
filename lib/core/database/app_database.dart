import 'package:drift/drift.dart';
import 'connection/connection.dart';

part 'app_database.g.dart';

@DataClassName('Baby')
class Babies extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get encryptedName => text()();
  TextColumn get encryptedDateOfBirth => text()();
  TextColumn get encryptedGender => text().nullable()();
}

@DataClassName('FeedingLog')
@TableIndex(name: 'idx_feed_baby_time', columns: {#babyId, #startTime})
@TableIndex(name: 'idx_feed_type', columns: {#type})
class FeedingLogs extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get babyId => integer().references(Babies, #id)();
  TextColumn get type => text()(); // breast, formula, solid, expressed
  DateTimeColumn get startTime => dateTime()();
  DateTimeColumn get endTime => dateTime().nullable()();
  
  // Volume for bottle/formula/expressed
  RealColumn get volumeAmount => real().nullable()(); // ml or oz
  TextColumn get volumeUnit => text().nullable()();
  
  // Breastfeeding specifics
  TextColumn get breastSide => text().nullable()(); // Left, Right, Both
  IntColumn get leftDurationSeconds => integer().nullable()();
  IntColumn get rightDurationSeconds => integer().nullable()();

  // Formula specifics
  TextColumn get formulaBrand => text().nullable()();
  RealColumn get formulaTemp => real().nullable()();

  // Solid food specifics
  TextColumn get solidFoodReaction => text().nullable()(); // Allergy, Dislike, Neutral
  TextColumn get solidFoodReactionPhotoPath => text().nullable()();

  TextColumn get notes => text().nullable()();
}

@DataClassName('SleepLog')
@TableIndex(name: 'idx_sleep_baby_time', columns: {#babyId, #startTime})
class SleepLogs extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get babyId => integer().references(Babies, #id)();
  DateTimeColumn get startTime => dateTime()();
  DateTimeColumn get endTime => dateTime().nullable()();
  TextColumn get notes => text().nullable()();
}

@DataClassName('DiaperLog')
@TableIndex(name: 'idx_diaper_baby_time', columns: {#babyId, #startTime})
@TableIndex(name: 'idx_diaper_type', columns: {#type})
class DiaperLogs extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get babyId => integer().references(Babies, #id)();
  DateTimeColumn get startTime => dateTime()();
  DateTimeColumn get endTime => dateTime().nullable()();
  TextColumn get type => text()(); // wet, dirty, both
  TextColumn get consistency => text().nullable()(); // hard, soft, watery
  TextColumn get color => text().nullable()(); // yellow, green, brown, bloody
  TextColumn get notes => text().nullable()();
}

@DataClassName('GrowthLog')
@TableIndex(name: 'idx_growth_baby_time', columns: {#babyId, #startTime})
class GrowthLogs extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get babyId => integer().references(Babies, #id)();
  DateTimeColumn get startTime => dateTime()();
  DateTimeColumn get endTime => dateTime().nullable()();
  RealColumn get weight => real().nullable()(); // stored in standard unit, e.g., kg
  RealColumn get height => real().nullable()(); // stored in cm
  RealColumn get headCircumference => real().nullable()(); // stored in cm
  TextColumn get notes => text().nullable()();
}

@DataClassName('ActivityLog')
@TableIndex(name: 'idx_activity_baby_time', columns: {#babyId, #startTime})
@TableIndex(name: 'idx_activity_type', columns: {#type})
class ActivityLogs extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get babyId => integer().references(Babies, #id)();
  TextColumn get type => text()(); // e.g., Tummy Time
  DateTimeColumn get startTime => dateTime()();
  DateTimeColumn get endTime => dateTime().nullable()();
  TextColumn get notes => text().nullable()();
  TextColumn get milestones => text().nullable()();
}

@DataClassName('MedicalLog')
@TableIndex(name: 'idx_medical_baby_time', columns: {#babyId, #startTime})
@TableIndex(name: 'idx_medical_type', columns: {#type})
class MedicalLogs extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get babyId => integer().references(Babies, #id)();
  TextColumn get type => text()(); // Medication, Vaccination
  TextColumn get name => text()();
  TextColumn get dosage => text().nullable()();
  DateTimeColumn get startTime => dateTime()();
  DateTimeColumn get endTime => dateTime().nullable()();
  DateTimeColumn get reminderTime => dateTime().nullable()();
  TextColumn get notes => text().nullable()();
}

@DriftDatabase(tables: [Babies, FeedingLogs, SleepLogs, DiaperLogs, GrowthLogs, ActivityLogs, MedicalLogs])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(openConnection());

  @override
  int get schemaVersion => 1;
}
