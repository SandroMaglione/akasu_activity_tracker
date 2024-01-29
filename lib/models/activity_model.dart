import 'package:akasu_activity_tracker/emoji.dart';
import 'package:equatable/equatable.dart';

class ActivityModel extends Equatable {
  final int id;
  final String name;
  final Emoji emoji;

  const ActivityModel({
    required this.id,
    required this.name,
    required this.emoji,
  });

  @override
  List<Object?> get props => [id, name, emoji];
}
