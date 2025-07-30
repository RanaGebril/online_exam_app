import 'package:online_exam_app_f/features/exam/api/client/exam_api_client.dart';
import 'package:online_exam_app_f/features/exam/data/data_sources/exam_remote_ds.dart';
import 'package:online_exam_app_f/features/exam/domain/model/exam_model.dart';
import 'package:online_exam_app_f/features/exam/domain/model/question_model.dart';
import 'package:online_exam_app_f/features/exam/domain/model/subject_model.dart';
import '../../../profile/data/datasources/user_local_storage.dart';


class ExamRemoteDsImpl implements ExamRemoteDs {
  final ExamApiClient examApiClient;

  ExamRemoteDsImpl(this.examApiClient);

  @override
  Future<List<SubjectModel>> getSubjects() async {
    final token = UserLocalStorage.getToken() ?? "";
    // print("🟢 Token used in request: Bearer $token");

    final subjectsRes = await examApiClient.getSubjects(token);
    return subjectsRes.subjects?.map((subjectDTO) => subjectDTO.toSubjectModel()).toList() ?? [];
  }

  @override
  Future<List<ExamModel>> getExamsBySubject(String subjectId) async {
    final token = UserLocalStorage.getToken() ?? "";
    final examsRes = await examApiClient.getExamsBySubject(subjectId, token);
    return examsRes.exams?.map((examDTO) => examDTO.toExamModel()).toList() ?? [];
  }

  @override
  Future<List<QuestionModel>> getExamQuestions(String examId) async {
    final token = UserLocalStorage.getUser()?.token ?? "";
    final questionRes = await examApiClient.getExamsQuestions(token, examId);
    return questionRes.questions?.map((questionDTO) => questionDTO.toQuestionModel()).toList() ?? [];
  }
}
