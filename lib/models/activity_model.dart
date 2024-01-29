import 'package:akasu_activity_tracker/emoji.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'activity_model.freezed.dart';

@freezed
class ActivityModel with _$ActivityModel {
  const factory ActivityModel({
    required int id,
    required String name,
    required Emoji emoji,
  }) = _ActivityModel;
}
