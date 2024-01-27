import 'package:akasu_activity_tracker/api_error.dart';
import 'package:akasu_activity_tracker/database.dart';
import 'package:akasu_activity_tracker/models/activity_model.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:fpdart/fpdart.dart';

final allActivities =
    ReaderTaskEither<Database, ApiError, IList<ActivityModel>>.Do(
  (_) async {
    final db = await _(ReaderTaskEither.ask());

    final data = await _(
      ReaderTaskEither.fromTaskEither(
        db.query(
          db.select(db.activity).get,
        ),
      ),
    );

    return data.toIList();
  },
);

ReaderTaskEither<Database, ApiError, int> addActivity({
  required String name,
  required String emoji,
}) =>
    ReaderTaskEither.Do(
      (_) async {
        final db = await _(ReaderTaskEither.ask());

        return _(
          ReaderTaskEither.fromTaskEither(
            db.query(
              () => db.into(db.activity).insert(
                    ActivityCompanion.insert(
                      name: name,
                      emoji: emoji,
                    ),
                  ),
            ),
          ),
        );
      },
    );

ReaderTaskEither<Database, ApiError, int> addEvent({
  required int activityId,
}) =>
    ReaderTaskEither.Do(
      (_) async {
        final db = await _(ReaderTaskEither.ask());

        return _(
          ReaderTaskEither.fromTaskEither(
            db.query(
              () => db.into(db.event).insert(
                    EventCompanion.insert(
                      activityId: activityId,
                      createdAt: DateTime.now(),
                    ),
                  ),
            ),
          ),
        );
      },
    );

ReaderTaskEither<Database, ApiError, int> deleteEvent({
  required int eventId,
}) =>
    ReaderTaskEither.Do(
      (_) async {
        final db = await _(ReaderTaskEither.ask());

        return _(
          ReaderTaskEither.fromTaskEither(
            db.query(
              (db.delete(db.event)
                    ..where(
                      (table) => table.id.equals(eventId),
                    ))
                  .go,
            ),
          ),
        );
      },
    );
