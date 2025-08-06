import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:online_exam_app_f/features/exam/api/client/exam_api_client.dart';
import 'package:online_exam_app_f/features/exam/api/data_sources_impl/exam_remote_ds_impl.dart';
import 'package:online_exam_app_f/features/exam/api/models/exam_dto.dart';
import 'package:online_exam_app_f/features/exam/api/models/questions_dto.dart';
import 'package:online_exam_app_f/features/exam/api/models/responses/exam_questions_response.dart';
import 'package:online_exam_app_f/features/exam/api/models/responses/exams_by_subject_response.dart';
import 'package:online_exam_app_f/features/exam/api/models/responses/subjects_response.dart';
import 'package:online_exam_app_f/features/exam/api/models/subject_dto.dart';
import 'package:online_exam_app_f/features/exam/domain/model/exam_model.dart';
import 'package:online_exam_app_f/features/exam/domain/model/question_model.dart';
import 'package:online_exam_app_f/features/exam/domain/model/subject_model.dart';

import 'exam_remote_ds_impl_test.mocks.dart';

@GenerateMocks([ExamApiClient])
void main() {
  late ExamRemoteDsImpl remoteDs;
  late MockExamApiClient mockApiClient;

  setUp(() {
    mockApiClient = MockExamApiClient();
    remoteDs = ExamRemoteDsImpl(mockApiClient);
  });

  group("get subjects", () {
    test("should return list of SubjectModel when API call is successful",
        () async {
      // Arrange
      final fakeSubjectsResponseList = SubjectsResponse(subjects: [
        SubjectDTO(name: "HTML", Id: "1"),
        SubjectDTO(name: "CSS", Id: "2"),
      ]);
      when(mockApiClient.getSubjects(any))
          .thenAnswer((_) async => fakeSubjectsResponseList);

      //act
      final result = await remoteDs.getSubjects("token");

      //assert
      expect(result, isA<List<SubjectModel>>());
    });

    test("should throw exception when API fails", () async {
      //arrange
      when(mockApiClient.getSubjects(any)).thenThrow(Exception("API Error while fetching exams"));

      //act & assert
      expect(() => remoteDs.getSubjects("token"), throwsException);
    },);

    test("should return empty list when API returns empty subject list", () async{
      //arrange
      final emptySubjectsResponse=SubjectsResponse(subjects: []);
      when(mockApiClient.getSubjects(any)).thenAnswer((_) async=> emptySubjectsResponse);

      //act
      final result=await remoteDs.getSubjects("token");

      //assert
      expect(result, isEmpty);
    },);

  });

  group(
    "get exams",
        () {
      test(
        "should return list of ExamModel when API call is successful",
            () async {
          //arrange
          final fakeExamsResponseList = ExamsBySubjectsResponse(exams: [
            ExamDTO(
              Id: "1",
              subject: "HTML",
              duration: 20,
            ),
            ExamDTO(
              Id: "2",
              subject: "CSS",
              duration: 20,
            ),
          ]);
          when(mockApiClient.getExamsBySubject(any, any)).thenAnswer(
                (_) async => fakeExamsResponseList,
          );

          //act
          final result = await remoteDs.getExamsBySubject("token", "subjectID");

          //assert
          expect(result, isA<List<ExamModel>>());
        },
      );

      test("should throw exception when API fails", () async {
        //arrange
        when(mockApiClient.getExamsBySubject(any, any)).thenThrow(Exception("API Error while fetching exams"));

        //act & assert
        expect(() => remoteDs.getExamsBySubject("subjectId", "token"), throwsException);
      },);

      test("should return empty list when API returns empty exams list", () async{
        //arrange
        final emptyExamsResponse=ExamsBySubjectsResponse(exams: []);
        when(mockApiClient.getExamsBySubject(any, any)).thenAnswer((_) async=> emptyExamsResponse,);

        //act
        final result=await remoteDs.getExamsBySubject("subjectId", "token");

        //assert
        expect(result, isEmpty);
      },);

    },
  );

  group("get questions", () {
    test("should return list of QuestionModel when API call is successful", ()async {
      //arrange
      final fackQuestionsList=ExamQuestionsResponse(
        questions: [
          QuestionsDTO(Id: "1",question: ""),
          QuestionsDTO(Id: "2",question: "")
        ]
      );
      when(mockApiClient.getExamsQuestions(any,any)).thenAnswer((_)async =>fackQuestionsList ,);

    //act
      final result=await remoteDs.getExamQuestions("examId", "token");

    //assert
      expect(result, isA<List<QuestionModel>>());
    },);

    test("should throw exception when API fails", () async{
      //arrange
      when(mockApiClient.getExamsQuestions(any,any)).thenThrow(Exception("API error while fetching questions"),);

      //assert
      expect(() async =>await remoteDs.getExamQuestions("examId", "token"), throwsException);
    },);


    test("should return empty list when API returns empty question list", () async{
      //arrange
      final emptyQuestionsResponse=ExamQuestionsResponse(questions: []);
      when(mockApiClient.getExamsQuestions(any, any)).thenAnswer((_) async=> emptyQuestionsResponse,);

      //act
      final result=await remoteDs.getExamQuestions("examId", "token");

      //assert
      expect(result, isEmpty);
    },);

  },);
}
