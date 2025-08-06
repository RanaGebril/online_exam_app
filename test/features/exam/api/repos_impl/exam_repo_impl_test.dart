import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:online_exam_app_f/core/error/failure.dart';
import 'package:online_exam_app_f/features/exam/data/data_sources/exam_remote_ds.dart';
import 'package:online_exam_app_f/features/exam/data/repos_impl/exam_repo_impl.dart';
import 'package:online_exam_app_f/features/exam/domain/model/exam_model.dart';
import 'package:online_exam_app_f/features/exam/domain/model/subject_model.dart';
import 'package:online_exam_app_f/features/profile/data/datasources/user_local_storage.dart';

import 'exam_repo_impl_test.mocks.dart';

@GenerateMocks([ExamRemoteDs, UserLocalStorage])
void main() {
  late ExamRepoImpl examRepoImpl;
  late MockExamRemoteDs mockExamRemoteDs;
  late MockUserLocalStorage mockUserLocalStorage;

  setUpAll(
    () {
      mockExamRemoteDs = MockExamRemoteDs();
      mockUserLocalStorage = MockUserLocalStorage();
      examRepoImpl = ExamRepoImpl(mockExamRemoteDs, mockUserLocalStorage);
      when(mockUserLocalStorage.getToken()).thenReturn("fakeToken");
    },
  );

  group(
    "get subjects",
    () {
      test(
        "should return Right(List<SubjectModel>) when successful",
        () async {
          final fakeSubjects = [
            SubjectModel(name: "HTML", id: "1", imageUrl: "")
          ];
          when(mockExamRemoteDs.getSubjects(any))
              .thenAnswer((_) async => fakeSubjects);
          final result = await examRepoImpl.getSubjects();
          expect(result, Right(fakeSubjects));
        },
      );
      test("should return Left(ServerFailure) when an exception occurs",
          () async {
        when(mockExamRemoteDs.getSubjects(any))
            .thenThrow(Exception("Server error"));
        final result = await examRepoImpl.getSubjects();
        expect(result.fold((l) => l, (r) => null), isA<ServerFailure>());
      });
    },
  );

  group(
    "get exams",
    () {
      test(
        "should return Right(List<ExamModel>) when successful",
        () async {
          final fakeExams = [ExamModel(id: "1", title: "")];
          when(mockExamRemoteDs.getExamsBySubject(any, any))
              .thenAnswer((_) async => fakeExams);
          final result = await examRepoImpl.getExamsBySubject("subject_id");
          expect(result, Right(fakeExams));
        },
      );

      test("should return Left(ServerFailure) when an exception occurs",
          () async {
        when(mockExamRemoteDs.getExamsBySubject(any, any))
            .thenThrow(Exception("Server error"));
        final result = await examRepoImpl.getExamsBySubject("subject_id");
        expect(result.fold((l) => l, (r) => null), isA<ServerFailure>());
      });
    },
  );

  group(
    "get questions",
    () {
      setUp(
        () {},
      );
      test("should return Right(List<ExamModel>) when successful", () async {
        when(mockExamRemoteDs.getExamQuestions(any, any))
            .thenThrow(Exception("Server error"));
        final result = await examRepoImpl.getExamQuestions("exam_id");
        expect(result.fold((l) => l, (r) => null), isA<ServerFailure>());
      });
      test("should return Left(ServerFailure) when an exception occurs",
          () async {
        when(mockExamRemoteDs.getExamQuestions(any, any))
            .thenThrow(Exception("Server error"));
        final result = await examRepoImpl.getExamQuestions("exam_id");
        expect(result.fold((l) => l, (r) => null), isA<ServerFailure>());
      });
    },
  );
}
