import 'package:dartz/dartz.dart';
import 'package:online_exam_app_f/core/error/failure.dart';
import 'package:online_exam_app_f/features/exam/domain/model/exam_model.dart';
import 'package:online_exam_app_f/features/exam/domain/model/subject_model.dart';
import 'package:online_exam_app_f/features/exam/domain/model/question_model.dart';

abstract class ExamRepo {
  Future<Either<Failure, List<SubjectModel>>> getSubjects();
  Future<Either<Failure, List<ExamModel>>> getExamsBySubject(String subject_id);
  Future<Either<Failure, List<QuestionModel>>> getExamQuestions(String exam_id);
}
