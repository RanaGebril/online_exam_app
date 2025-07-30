// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'questions_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuestionsDTO _$QuestionsDTOFromJson(Map<String, dynamic> json) => QuestionsDTO(
      Id: json['_id'] as String?,
      question: json['question'] as String?,
      answers: (json['answers'] as List<dynamic>?)
          ?.map((e) => AnswersDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
      type: json['type'] as String?,
      correct: json['correct'] as String?,
      subject: json['subject'] == null
          ? null
          : SubjectDTO.fromJson(json['subject'] as Map<String, dynamic>),
      exam: json['exam'] == null
          ? null
          : ExamDTO.fromJson(json['exam'] as Map<String, dynamic>),
      createdAt: json['createdAt'] as String?,
    );

Map<String, dynamic> _$QuestionsDTOToJson(QuestionsDTO instance) =>
    <String, dynamic>{
      '_id': instance.Id,
      'question': instance.question,
      'answers': instance.answers,
      'type': instance.type,
      'correct': instance.correct,
      'subject': instance.subject,
      'exam': instance.exam,
      'createdAt': instance.createdAt,
    };
