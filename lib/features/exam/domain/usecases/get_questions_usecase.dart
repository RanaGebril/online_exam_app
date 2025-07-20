import 'package:injectable/injectable.dart';
import 'package:online_exam_app_f/features/exam/domain/model/question_model.dart';
import 'package:online_exam_app_f/features/exam/domain/repos/exam_repo.dart';

@injectable
class GetQuestionsUsecase {
  ExamRepo examRepo;
  GetQuestionsUsecase(this.examRepo);

  Future<List<QuestionModel>> call(String exam_id){
    return examRepo.getExamQuestions(exam_id);
  }
}