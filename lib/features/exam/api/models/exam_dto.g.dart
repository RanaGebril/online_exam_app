// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exam_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExamDTO _$ExamDTOFromJson(Map<String, dynamic> json) => ExamDTO(
  Id: json['_id'] as String?,
  title: json['title'] as String?,
  duration: (json['duration'] as num?)?.toInt(),
  subject: json['subject'] as String?,
  numberOfQuestions: (json['numberOfQuestions'] as num?)?.toInt(),
  active: json['active'] as bool?,
  createdAt: json['createdAt'] as String?,
);

Map<String, dynamic> _$ExamDTOToJson(ExamDTO instance) => <String, dynamic>{
  '_id': instance.Id,
  'title': instance.title,
  'duration': instance.duration,
  'subject': instance.subject,
  'numberOfQuestions': instance.numberOfQuestions,
  'active': instance.active,
  'createdAt': instance.createdAt,
};
