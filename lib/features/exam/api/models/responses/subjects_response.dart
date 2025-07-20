import 'package:json_annotation/json_annotation.dart';
import 'package:online_exam_app_f/features/exam/api/models/subject_dto.dart';
import '../metadata_dto.dart';

part 'subjects_response.g.dart';

@JsonSerializable()
class SubjectsResponse {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "metadata")
  final MetadataDTO? metadata;
  @JsonKey(name: "subjects")
  final List<SubjectDTO>? subjects;

  SubjectsResponse ({
    this.message,
    this.metadata,
    this.subjects,
  });

  factory SubjectsResponse.fromJson(Map<String, dynamic> json) {
    return _$SubjectsResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$SubjectsResponseToJson(this);
  }
}



