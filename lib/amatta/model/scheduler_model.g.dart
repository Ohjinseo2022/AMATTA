// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scheduler_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SchedulerModel _$SchedulerModelFromJson(Map<String, dynamic> json) =>
    SchedulerModel(
      id: json['id'] as String,
      scheduleName: json['scheduleName'] as String,
      startDate: DataUtils.stringToDateTime(json['startDate'] as String),
      endDate: DataUtils.stringToDateTime(json['endDate'] as String),
      createdDate: json['createdDate'] as String,
    );

Map<String, dynamic> _$SchedulerModelToJson(SchedulerModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'scheduleName': instance.scheduleName,
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate.toIso8601String(),
      'createdDate': instance.createdDate,
    };
