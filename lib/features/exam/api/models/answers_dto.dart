import 'package:json_annotation/json_annotation.dart';
import 'package:online_exam_app_f/features/exam/domain/model/answer_model.dart';

part 'answers_dto.g.dart';

@JsonSerializable()
class AnswersDTO {
  @JsonKey(name: "answer")
  final String? answer;
  @JsonKey(name: "key")
  final String? key;

  AnswersDTO({this.answer, this.key});

  factory AnswersDTO.fromJson(Map<String, dynamic> json) {
    return _$AnswersDTOFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$AnswersDTOToJson(this);
  }

  AnswerModel toAnswerModel() =>
      AnswerModel(answer: answer ?? '', key: key ?? '');
}
