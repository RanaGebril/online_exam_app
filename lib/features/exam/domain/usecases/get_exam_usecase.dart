import 'package:injectable/injectable.dart';
import 'package:online_exam_app_f/features/exam/domain/model/exam_model.dart';
import 'package:online_exam_app_f/features/exam/domain/repos/exam_repo.dart';
import 'package:online_exam_app_f/core/error/failure.dart';
import 'package:dartz/dartz.dart';


class GetExamUsecase {
  ExamRepo examRepo;
  GetExamUsecase(this.examRepo);

  Future<Either<Failure, List<ExamModel>>> call(String Subject_id) {
    return examRepo.getExamsBySubject(Subject_id);
  }
}
