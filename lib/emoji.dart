import 'package:drift/drift.dart';

sealed class Emoji {
  const Emoji();
}

class Smile extends Emoji {
  const Smile();
  @override
  String toString() {
    return "😁";
  }
}

class Rocket extends Emoji {
  const Rocket();
  @override
  String toString() {
    return "🚀";
  }
}

class Dart extends Emoji {
  const Dart();
  @override
  String toString() {
    return "🎯";
  }
}

class EmojiConverter extends TypeConverter<Emoji, String> {
  @override
  Emoji fromSql(String fromDb) => switch (fromDb) {
        "😁" => const Smile(),
        "🚀" => const Rocket(),
        "🎯" => const Dart(),
        _ => const Dart(),
      };

  @override
  String toSql(Emoji value) => value.toString();
}
