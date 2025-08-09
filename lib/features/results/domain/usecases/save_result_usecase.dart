import 'package:online_exam_app_f/features/results/domain/models/completed_exam.dart';
import 'package:online_exam_app_f/features/results/domain/repo/results_repo.dart';

class SaveResultUsecase {
  final ResultsRepo repo;

  SaveResultUsecase(this.repo);

  Future<void> call(CompletedExam completedExam) async {
    return await repo.saveResult(completedExam);
  }
}
