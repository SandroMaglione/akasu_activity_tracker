import 'package:drift/drift.dart';
import 'package:fpdart/fpdart.dart';

typedef Day = ({int day, int month, int year});

extension on Day {
  String get toSql => "$day/$month/$year";
}

class DayConverter extends TypeConverter<Day, String> {
  @override
  Day fromSql(String fromDb) => Option<Day>.Do((_) {
        final split = fromDb.split("/");
        final day = _(
          Option.fromNullable(split.elementAtOrNull(0)).flatMap(
            (str) => str.toIntOption,
          ),
        );
        final month = _(
          Option.fromNullable(split.elementAtOrNull(1)).flatMap(
            (str) => str.toIntOption,
          ),
        );
        final year = _(
          Option.fromNullable(split.elementAtOrNull(2)).flatMap(
            (str) => str.toIntOption,
          ),
        );

        return (day: day, month: month, year: year);
      }).getOrElse(
        () => (day: 0, month: 0, year: 0),
      );

  @override
  String toSql(Day value) => value.toSql;
}
