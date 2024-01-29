import 'package:akasu_activity_tracker/api_error.dart';
import 'package:akasu_activity_tracker/database.dart';
import 'package:akasu_activity_tracker/models/activity_model.dart';
import 'package:akasu_activity_tracker/models/event_model.dart';
import 'package:akasu_activity_tracker/typedefs.dart';
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
        final dateTime = await _(
          ReaderTaskEither.fromIO(dateNow),
        );

        return _(
          ReaderTaskEither.fromTaskEither(
            db.query(
              () => db.into(db.event).insert(
                    EventCompanion.insert(
                      activityId: activityId,
                      createdAt: (
                        day: dateTime.day,
                        month: dateTime.month,
                        year: dateTime.year
                      ),
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

ReaderTaskEither<Database, ApiError, IList<EventModel>> getEventsInDay({
  required Day day,
  required ActivityModel activityModel,
}) =>
    ReaderTaskEither.Do(
      (_) async {
        final db = await _(ReaderTaskEither.ask());

        final list = await _(
          ReaderTaskEither.fromTaskEither(
            db.query(
              (db.select(db.event)
                    ..where(
                      (table) => table.activityId.equals(
                        activityModel.id,
                      ),
                    )
                    ..where(
                      (table) => table.createdAt.equals(
                        DayConverter().toSql(day),
                      ),
                    ))
                  .get,
            ),
          ),
        );

        return list.toIList();
      },
    );
