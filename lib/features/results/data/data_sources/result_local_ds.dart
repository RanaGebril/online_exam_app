import 'package:hive/hive.dart';

import '../../domain/models/completed_exam.dart';

class ResultsLocalDs {
  static const String _boxName = 'completed_exams';

  Future<void> saveResult(CompletedExam completedExam) async {
    final box = await Hive.openBox<CompletedExam>(_boxName);
    await box.add(completedExam);
  }

  Future<List<CompletedExam>> getResults() async {
    final box = await Hive.openBox<CompletedExam>(_boxName);
    return box.values.toList();
  }
}