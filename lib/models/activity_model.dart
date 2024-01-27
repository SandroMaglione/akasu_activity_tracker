import 'package:freezed_annotation/freezed_annotation.dart';

part 'activity_model.freezed.dart';
part 'activity_model.g.dart';

@freezed
class ActivityModel with _$ActivityModel {
  const factory ActivityModel({
    required String name,
    required String emoji,
  }) = _ActivityModel;

  factory ActivityModel.fromJson(Map<String, Object?> json) =>
      _$ActivityModelFromJson(json);
}
