import 'package:akasu_activity_tracker/typedefs.dart';
import 'package:equatable/equatable.dart';

class EventModel extends Equatable {
  final int id;
  final int activityId;
  final Day createdAt;

  const EventModel({
    required this.id,
    required this.activityId,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [id, activityId, createdAt];
}
