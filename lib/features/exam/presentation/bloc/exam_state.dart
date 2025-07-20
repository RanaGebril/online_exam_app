import 'package:online_exam_app_f/features/exam/domain/model/exam_model.dart';
import 'package:online_exam_app_f/features/exam/domain/model/question_model.dart';
import 'package:online_exam_app_f/features/exam/domain/model/subject_model.dart';

enum RequestState { init, loading, success, error }
class ExamState {
   RequestState? subjectsRequestState;
   List<SubjectModel>? subjects;

   RequestState? examsRequestState;
   List<ExamModel>? exams;

   RequestState? questionsRequestState;
   List<QuestionModel>? questions;

   String? errorMessage;

   ExamState({
    this.subjectsRequestState,
    this.subjects,
     this.examsRequestState,
     this.exams,
    this.questionsRequestState,
    this.questions,
    this.errorMessage,
  });

   ExamState copyWith({
    RequestState? subjectsRequestState,
    List<SubjectModel>? subjects,
     RequestState? examsRequestState,
     List<ExamModel>? exams,
     RequestState? questionsRequestState,
     List<QuestionModel>? questions,
     String? errorMessage,

  }) {
    return ExamState(
      subjectsRequestState: subjectsRequestState ?? this.subjectsRequestState,
      subjects: subjects ?? this.subjects,
      examsRequestState: examsRequestState ??this.examsRequestState,
      exams: exams??this.exams,
      questionsRequestState: questionsRequestState??this.questionsRequestState,
      questions: questions??this.questions,
      errorMessage: errorMessage ?? this.errorMessage,

    );
  }
}

class ExamInitial extends ExamState {
   ExamInitial() : super(
    errorMessage: "",
       subjectsRequestState: RequestState.init,
    examsRequestState: RequestState.init,
    questionsRequestState: RequestState.init,
    questions: [],
    exams: [],
    subjects: []
  );
}
