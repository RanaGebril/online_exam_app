import 'package:json_annotation/json_annotation.dart';
import 'package:online_exam_app_f/features/exam/api/models/metadata_dto.dart';
import 'package:online_exam_app_f/features/exam/api/models/exam_dto.dart';

part 'exams_by_subject_response.g.dart';

@JsonSerializable()
class ExamsBySubjectsResponse {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "metadata")
  final MetadataDTO? metadata;
  @JsonKey(name: "exams")
  final List<ExamDTO>? exams;

  ExamsBySubjectsResponse ({
    this.message,
    this.metadata,
    this.exams,
  });

  factory ExamsBySubjectsResponse.fromJson(Map<String, dynamic> json) {
    return _$ExamsBySubjectsResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ExamsBySubjectsResponseToJson(this);
  }
}


