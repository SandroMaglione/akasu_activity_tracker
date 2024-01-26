import 'package:akasu_activity_tracker/database.dart';
import 'package:akasu_activity_tracker/models/activity_model.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:fpdart/fpdart.dart';

sealed class ApiError {
  const ApiError();
}

class QueryError extends ApiError {
  final Object error;
  final StackTrace stackTrace;
  const QueryError(this.error, this.stackTrace);
}

final allActivities =
    ReaderTaskEither<Database, ApiError, IList<ActivityModel>>.Do(
  (_) async {
    final db = await _(ReaderTaskEither.ask());

    final data = await _(
      ReaderTaskEither.fromTaskEither(
        TaskEither.tryCatch(
          () => db.select(db.activity).get(),
          QueryError.new,
        ),
      ),
    );

    return data.toIList();
  },
);
