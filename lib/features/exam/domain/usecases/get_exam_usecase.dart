import 'package:injectable/injectable.dart';
import 'package:online_exam_app_f/features/exam/domain/model/exam_model.dart';
import 'package:online_exam_app_f/features/exam/domain/repos/exam_repo.dart';

@injectable
class GetExamUsecase {
  ExamRepo examRepo;
  GetExamUsecase(this.examRepo);

  Future<List<ExamModel>> call(String Subject_id) {
    return examRepo.getExamsBySubject(Subject_id);
  }
}
