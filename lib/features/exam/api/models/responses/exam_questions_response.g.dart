// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exam_questions_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExamQuestionsResponse _$ExamQuestionsResponseFromJson(
  Map<String, dynamic> json,
) => ExamQuestionsResponse(
  message: json['message'] as String?,
  questions:
      (json['questions'] as List<dynamic>?)
          ?.map((e) => QuestionsDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
);

Map<String, dynamic> _$ExamQuestionsResponseToJson(
  ExamQuestionsResponse instance,
) => <String, dynamic>{
  'message': instance.message,
  'questions': instance.questions,
};
