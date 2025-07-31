import 'package:hive/hive.dart';
import 'package:online_exam_app_f/features/exam/domain/model/subject_model.dart';

part 'completed_exam.g.dart';

@HiveType(typeId: 1) // تأكد من أن typeId مختلف عن أي نوع آخر في Hive
class CompletedExam {
  @HiveField(0)
  final String examId;

  @HiveField(1)
  final DateTime completionDate;

  @HiveField(2)
  final int correctAnswers;

  @HiveField(3)
  final int totalQuestions;

  @HiveField(4)
  final Map<String, int> selectedAnswers; // questionId -> selectedIndex

  @HiveField(5)
  final String subjectName;

  @HiveField(6)
  final String subjectImage;

  @HiveField(7)
  final int questionsNum;

  @HiveField(8)
  final int duration;

  CompletedExam(
      {required this.examId,
      required this.completionDate,
      required this.correctAnswers,
      required this.totalQuestions,
      required this.selectedAnswers,
      required this.subjectName,
      required this.subjectImage,
      required this.questionsNum,
      required this.duration});
}
