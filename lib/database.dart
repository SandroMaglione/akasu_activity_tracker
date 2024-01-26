import 'dart:io';

import 'package:akasu_activity_tracker/models/activity_model.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:sqlite3/sqlite3.dart';
import 'package:sqlite3_flutter_libs/sqlite3_flutter_libs.dart';

part 'database.g.dart';

@UseRowClass(ActivityModel)
class Activity extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get emojy => text()();
}

@DriftDatabase(tables: [Activity])
class Database extends _$Database {
  Database() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() => LazyDatabase(
      () async {
        final dbFolder = await getApplicationDocumentsDirectory();
        final file = File(path.join(dbFolder.path, 'db.sqlite'));

        if (Platform.isAndroid) {
          await applyWorkaroundToOpenSqlite3OnOldAndroidVersions();
        }

        final cachebase = (await getTemporaryDirectory()).path;
        sqlite3.tempDirectory = cachebase;

        return NativeDatabase.createInBackground(file);
      },
    );