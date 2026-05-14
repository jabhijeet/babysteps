import 'package:drift/drift.dart';
import 'native.dart' if (dart.library.js_util) 'web.dart';

QueryExecutor openConnection() => openPlatformConnection();
