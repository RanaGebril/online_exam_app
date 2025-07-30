import 'package:json_annotation/json_annotation.dart';
import 'package:online_exam_app_f/features/exam/domain/model/exam_model.dart';

part 'exam_dto.g.dart';

@JsonSerializable()
class ExamDTO {
  @JsonKey(name: "_id")
  final String? Id;
  @JsonKey(name: "title")
  final String? title;
  @JsonKey(name: "duration")
  final int? duration;
  @JsonKey(name: "subject")
  final String? subject;
  @JsonKey(name: "numberOfQuestions")
  final int? numberOfQuestions;
  @JsonKey(name: "active")
  final bool? active;
  @JsonKey(name: "createdAt")
  final String? createdAt;

  ExamDTO({
    this.Id,
    this.title,
    this.duration,
    this.subject,
    this.numberOfQuestions,
    this.active,
    this.createdAt,
  });

  factory ExamDTO.fromJson(Map<String, dynamic> json) {
    return _$ExamDTOFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ExamDTOToJson(this);
  }

  ExamModel toExamModel() =>
      ExamModel(
        questionsNum: numberOfQuestions ?? 0,
        id: Id ?? "",
        title: title ?? "",
        duration: duration ?? 0,
      );
}