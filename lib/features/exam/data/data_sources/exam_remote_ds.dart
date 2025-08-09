import 'package:online_exam_app_f/features/exam/domain/model/exam_model.dart';
import 'package:online_exam_app_f/features/exam/domain/model/question_model.dart';
import 'package:online_exam_app_f/features/exam/domain/model/subject_model.dart';

abstract class ExamRemoteDs {
  Future<List<SubjectModel>> getSubjects(String token);

  Future<List<ExamModel>> getExamsBySubject(String subject_id,String token);

  Future<List<QuestionModel>> getExamQuestions(String exam_id,String token);
}