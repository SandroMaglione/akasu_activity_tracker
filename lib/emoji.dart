import 'package:drift/drift.dart';

enum Emoji {
  smile,
  rocket,
  dart;

  @override
  String toString() => switch (this) {
        Emoji.smile => "😁",
        Emoji.rocket => "🚀",
        Emoji.dart => "🎯",
      };
}

class EmojiConverter extends TypeConverter<Emoji, String> {
  @override
  Emoji fromSql(String fromDb) => Emoji.values.firstWhere(
        (emoji) => emoji.toString() == fromDb,
        orElse: () => Emoji.dart,
      );

  @override
  String toSql(Emoji value) => value.toString();
}
