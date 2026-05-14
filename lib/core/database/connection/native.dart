import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

QueryExecutor openPlatformConnection() {
  return driftDatabase(name: 'babysteps');
}
