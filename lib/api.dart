import 'package:akasu_activity_tracker/models/activity_model.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class Database {
  List<ActivityModel> get allActivities;
}

sealed class ApiError {}

final allActivities =
    ReaderTaskEither<Database, ApiError, IList<ActivityModel>>.Do(
  (_) async {
    final db = await _(ReaderTaskEither.ask());
    return db.allActivities.toIList();
  },
);
