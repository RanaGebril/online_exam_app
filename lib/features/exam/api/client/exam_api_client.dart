import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam_app_f/core/utils/constants/api_endpionts.dart';
import 'package:online_exam_app_f/core/utils/constants/api_parameters.dart';
import 'package:online_exam_app_f/features/exam/api/models/responses/exam_questions_response.dart';
import 'package:online_exam_app_f/features/exam/api/models/responses/exams_by_subject_response.dart';
import 'package:online_exam_app_f/features/exam/api/models/responses/subjects_response.dart';
import 'package:retrofit/retrofit.dart';

part 'exam_api_client.g.dart';

@injectable
@RestApi(baseUrl: ApiEndPionts.baseUrl)
abstract class ExamApiClient {
  @factoryMethod
  factory ExamApiClient(Dio dio) = _ExamApiClient;

  @GET(ApiEndPionts.subjectsEndPoint)
  Future<SubjectsResponse> getSubjects({
    @Query(ApiParameters.numberOfPages) int page = 1,
    @Query(ApiParameters.pageLimit) int limit = 10,
  });

  @GET(ApiEndPionts.examsBySubjectEndPoint)
  Future<ExamsBySubjectsResponse> getExamsBySubject(
    @Query(ApiParameters.subjectID) String subjectID, {
    @Query(ApiParameters.numberOfPages) int page = 1,
    @Query(ApiParameters.pageLimit) int limit = 10,
  });

  @GET(ApiEndPionts.examQuestionsEndPoint)
  Future<ExamQuestionsResponse> getExamsQuestions(
      @Query(ApiParameters.examID) String examID);
}
