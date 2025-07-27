import 'package:injectable/injectable.dart';
import 'package:online_exam_app_f/features/exam/domain/model/subject_model.dart';


class SearchSubjectsUseCase {
  List<SubjectModel> call(String keyword, List<SubjectModel> allSubjects) {
    final lowerKeyword = keyword.trim().toLowerCase();
    return allSubjects.where(
            (subject) => subject.name.toLowerCase().contains(lowerKeyword)
    ).toList();
  }
}
