import '../models/completed_exam.dart';

abstract class ResultsRepo {
  Future<void> saveResult(CompletedExam completedExam);
  Future<List<CompletedExam>> getResults();
}