import 'package:json_annotation/json_annotation.dart';
import 'package:online_exam_app_f/features/exam/api/models/questions_dto.dart';

part 'exam_questions_response.g.dart';

@JsonSerializable()
class ExamQuestionsResponse {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "questions")
  final List<QuestionsDTO>? questions;

  ExamQuestionsResponse ({
    this.message,
    this.questions,
  });

  factory ExamQuestionsResponse.fromJson(Map<String, dynamic> json) {
    return _$ExamQuestionsResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ExamQuestionsResponseToJson(this);
  }
}



