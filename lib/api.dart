import 'package:akasu_activity_tracker/api_error.dart';
import 'package:akasu_activity_tracker/database.dart';
import 'package:akasu_activity_tracker/emoji.dart';
import 'package:akasu_activity_tracker/typedefs.dart';
import 'package:fpdart/fpdart.dart';

ReaderTaskEither<Database, ApiError, int> addActivity({
  required String name,
  required Emoji emoji,
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
  required Day day,
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
                      createdAt: day,
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
