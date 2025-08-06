// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exams_by_subject_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExamsBySubjectsResponse _$ExamsBySubjectsResponseFromJson(
        Map<String, dynamic> json) =>
    ExamsBySubjectsResponse(
      message: json['message'] as String?,
      metadata: json['metadata'] == null
          ? null
          : MetadataDTO.fromJson(json['metadata'] as Map<String, dynamic>),
      exams: (json['exams'] as List<dynamic>?)
          ?.map((e) => ExamDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ExamsBySubjectsResponseToJson(
        ExamsBySubjectsResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'metadata': instance.metadata,
      'exams': instance.exams,
    };
