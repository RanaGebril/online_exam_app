import 'package:injectable/injectable.dart';
import 'package:online_exam_app_f/features/exam/domain/model/subject_model.dart';
import 'package:online_exam_app_f/features/exam/domain/repos/exam_repo.dart';

@injectable
class GetSubjectsUsecase {
  ExamRepo examRepo;
  GetSubjectsUsecase(this.examRepo);

  Future<List<SubjectModel>> call(){
    return examRepo.getSubjects();
  }
}