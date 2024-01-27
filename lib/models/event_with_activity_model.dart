import 'package:akasu_activity_tracker/models/activity_model.dart';
import 'package:akasu_activity_tracker/models/event_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_with_activity_model.freezed.dart';
part 'event_with_activity_model.g.dart';

@freezed
class EventWithActivityModel with _$EventWithActivityModel {
  const factory EventWithActivityModel({
    required ActivityModel activity,
    required EventModel event,
  }) = _EventWithActivityModel;

  factory EventWithActivityModel.fromJson(Map<String, Object?> json) =>
      _$EventWithActivityModelFromJson(json);
}
