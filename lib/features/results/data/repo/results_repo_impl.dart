import '../../domain/models/completed_exam.dart';
import '../../domain/repo/results_repo.dart';
import '../data_sources/result_local_ds.dart';

class ResultsRepoImpl implements ResultsRepo {
  final ResultsLocalDs localDs;

  ResultsRepoImpl(this.localDs);

  @override
  Future<void> saveResult(CompletedExam completedExam) async {
    return await localDs.saveResult(completedExam);
  }

  @override
  Future<List<CompletedExam>> getResults() async {
    return await localDs.getResults();
  }
}