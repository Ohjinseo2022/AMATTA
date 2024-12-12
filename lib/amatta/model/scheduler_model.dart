import 'package:amatta_front/common/model/model_with_id.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:amatta_front/common/utils/data_utils.dart';
part "scheduler_model.g.dart";

@JsonSerializable()
class SchedulerModel implements IModelWithId {
  @override
  final String id;
  final String scheduleName;
  @JsonKey(fromJson: DataUtils.stringToDateTime)
  final DateTime startDate;
  @JsonKey(fromJson: DataUtils.stringToDateTime)
  final DateTime endDate;
  final String createdDate;

  SchedulerModel({
    required this.id,
    required this.scheduleName,
    required this.startDate,
    required this.endDate,
    required this.createdDate,
  });
  factory SchedulerModel.fromJson(Map<String, dynamic> json) =>
      _$SchedulerModelFromJson(json);

  Map<String, dynamic> toJson() => _$SchedulerModelToJson(this);
}
