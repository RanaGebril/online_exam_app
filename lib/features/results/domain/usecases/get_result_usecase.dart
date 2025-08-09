import '../models/completed_exam.dart';
import '../repo/results_repo.dart';

class GetResultsUsecase {
  final ResultsRepo repo;

  GetResultsUsecase(this.repo);

  Future<List<CompletedExam>> call() async {
    return await repo.getResults();
  }
}
