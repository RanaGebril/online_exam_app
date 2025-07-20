import 'package:easy_localization/easy_localization.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam_app_f/core/error/failure.dart';
import 'package:online_exam_app_f/features/exam/data/data_sources/exam_remote_ds.dart';
import 'package:online_exam_app_f/features/exam/domain/model/exam_model.dart';
import 'package:online_exam_app_f/features/exam/domain/model/subject_model.dart';
import 'package:online_exam_app_f/features/exam/domain/repos/exam_repo.dart';
import 'package:online_exam_app_f/features/exam/domain/model/question_model.dart';
import 'package:dartz/dartz.dart';

@Injectable(as: ExamRepo)
class ExamRepoImpl implements ExamRepo{
  ExamRemoteDs examRemoteDs;
  ExamRepoImpl(this.examRemoteDs);

  @override
  Future<Either<Failure, List<SubjectModel>>> getSubjects() async{
    try {
      return right(await examRemoteDs.getSubjects());
    }
    catch (e) {
      return left(ServerFailure("Error loading subjects"));
    }

  }

  @override
  Future<Either<Failure, List<ExamModel>>> getExamsBySubject(String subject_id) async{
    try{
      return right(await examRemoteDs.getExamsBySubject(subject_id));
    }
    catch(e){
      return left(ServerFailure("Error loading exams"));
    }

  }

  @override
  Future<Either<Failure, List<QuestionModel>>> getExamQuestions(String exam_id) async{
    try{
      return right(await examRemoteDs.getExamQuestions(exam_id));
    }
    catch(e){
      return left(ServerFailure("Error loading questions"));
    }
  }

}