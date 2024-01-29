import 'package:akasu_activity_tracker/typedefs.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_model.freezed.dart';

@freezed
class EventModel with _$EventModel {
  const factory EventModel({
    required int id,
    required int activityId,
    required Day createdAt,
  }) = _EventModel;
}
