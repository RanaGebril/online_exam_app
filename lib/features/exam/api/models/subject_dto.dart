import 'package:json_annotation/json_annotation.dart';
import 'package:online_exam_app_f/features/exam/domain/model/subject_model.dart';

part 'subject_dto.g.dart';


@JsonSerializable()
class SubjectDTO {
  @JsonKey(name: "_id")
  final String? Id;
  @JsonKey(name: "name")
  final String? name;
  @JsonKey(name: "icon")
  final String? icon;
  @JsonKey(name: "createdAt")
  final String? createdAt;

  SubjectDTO ({
    this.Id,
    this.name,
    this.icon,
    this.createdAt,
  });

  factory SubjectDTO.fromJson(Map<String, dynamic> json) {
    return _$SubjectDTOFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$SubjectDTOToJson(this);
  }

  SubjectModel toSubjectModel () => SubjectModel(id: Id??"", name: name??"", imageUrl: icon??"");
}
