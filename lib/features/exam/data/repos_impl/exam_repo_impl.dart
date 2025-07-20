import 'package:injectable/injectable.dart';
import 'package:online_exam_app_f/features/exam/data/data_sources/exam_remote_ds.dart';
import 'package:online_exam_app_f/features/exam/domain/model/exam_model.dart';
import 'package:online_exam_app_f/features/exam/domain/model/subject_model.dart';
import 'package:online_exam_app_f/features/exam/domain/repos/exam_repo.dart';
import 'package:online_exam_app_f/features/exam/domain/model/question_model.dart';

@Injectable(as: ExamRepo)
class ExamRepoImpl implements ExamRepo{
  ExamRemoteDs examRemoteDs;
  ExamRepoImpl(this.examRemoteDs);

  @override
  Future<List<SubjectModel>> getSubjects() {
   return examRemoteDs.getSubjects();
  }

  @override
  Future<List<ExamModel>> getExamsBySubject(String subject_id){
   return examRemoteDs.getExamsBySubject(subject_id);
  }

  @override
  Future<List<QuestionModel>> getExamQuestions(String exam_id){
    return examRemoteDs.getExamQuestions(exam_id);
  }

}