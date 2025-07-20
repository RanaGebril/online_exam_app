import 'package:injectable/injectable.dart';
import 'package:online_exam_app_f/features/exam/api/client/exam_api_client.dart';
import 'package:online_exam_app_f/features/exam/api/models/responses/exam_questions_response.dart';
import 'package:online_exam_app_f/features/exam/api/models/responses/exams_by_subject_response.dart';
import 'package:online_exam_app_f/features/exam/api/models/responses/subjects_response.dart';
import 'package:online_exam_app_f/features/exam/data/data_sources/exam_remote_ds.dart';
import 'package:online_exam_app_f/features/exam/domain/model/exam_model.dart';
import 'package:online_exam_app_f/features/exam/domain/model/question_model.dart';
import 'package:online_exam_app_f/features/exam/domain/model/subject_model.dart';

@Injectable(as: ExamRemoteDs)
class ExamRemoteDsImpl implements ExamRemoteDs{
  ExamApiClient examApiClient;

  ExamRemoteDsImpl(this.examApiClient);

  @override
  Future<List<SubjectModel>> getSubjects()async {
    SubjectsResponse subjectsRes= await examApiClient.getSubjects();
    List<SubjectModel> subjects=subjectsRes.subjects!.map((subjectDTO) => subjectDTO.toSubjectModel()).toList() ??[];
    return subjects;
  }

  Future<List<ExamModel>> getExamsBySubject(String subject_id)async{
    ExamsBySubjectsResponse examsRes=await examApiClient.getExamsBySubject(subject_id);
    List<ExamModel> exams=examsRes.exams?.map((examDTO) => examDTO.toExamModel()).toList()??[];
    return exams;
  }

  @override
  Future<List<QuestionModel>> getExamQuestions(String exam_id) async {
    ExamQuestionsResponse questionRes = await examApiClient.getExamsQuestions(exam_id);
    List<QuestionModel> questions = questionRes.questions?.map((questionDTO) => questionDTO.toQuestionModel()).toList() ?? [];
    return questions;
  }
  
  
}