import 'package:json_annotation/json_annotation.dart';
import 'package:online_exam_app_f/features/exam/api/models/subject_dto.dart';
import 'package:online_exam_app_f/features/exam/domain/model/question_model.dart';

import 'answers_dto.dart';
import 'exam_dto.dart';

part 'questions_dto.g.dart';

@JsonSerializable()
class QuestionsDTO {
  @JsonKey(name: "_id")
  final String? Id;
  @JsonKey(name: "question")
  final String? question;
  @JsonKey(name: "answers")
  final List<AnswersDTO>? answers;
  @JsonKey(name: "type")
  final String? type;
  @JsonKey(name: "correct")
  final String? correct;
  @JsonKey(name: "subject")
  final SubjectDTO? subject;
  @JsonKey(name: "exam")
  final ExamDTO? exam;
  @JsonKey(name: "createdAt")
  final String? createdAt;

  QuestionsDTO({
    this.Id,
    this.question,
    this.answers,
    this.type,
    this.correct,
    this.subject,
    this.exam,
    this.createdAt,
  });

  factory QuestionsDTO.fromJson(Map<String, dynamic> json) {
    return _$QuestionsDTOFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$QuestionsDTOToJson(this);
  }

  QuestionModel toQuestionModel() => QuestionModel(
    id: Id ?? "",
    question: question ?? "",
    answers: answers?.map((answerDto) => answerDto.toAnswerModel()).toList() ?? [],
    correctAnswer: correct??null
  );
}
