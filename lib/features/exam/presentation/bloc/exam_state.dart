import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart'; // علشان @immutable
import 'package:online_exam_app_f/features/exam/domain/model/exam_model.dart';
import 'package:online_exam_app_f/features/exam/domain/model/question_model.dart';
import 'package:online_exam_app_f/features/exam/domain/model/subject_model.dart';

enum RequestState { init, loading, success, error }

@immutable
class ExamState extends Equatable {
  final RequestState subjectsRequestState;
  final List<SubjectModel> subjects;

  final RequestState examsRequestState;
  final List<ExamModel> exams;

  final RequestState questionsRequestState;
  final List<QuestionModel> questions;

  final String errorMessage;

  const ExamState({
    this.subjectsRequestState = RequestState.init,
    this.subjects = const [],
    this.examsRequestState = RequestState.init,
    this.exams = const [],
    this.questionsRequestState = RequestState.init,
    this.questions = const [],
    this.errorMessage = '',
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
      examsRequestState: examsRequestState ?? this.examsRequestState,
      exams: exams ?? this.exams,
      questionsRequestState: questionsRequestState ?? this.questionsRequestState,
      questions: questions ?? this.questions,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    subjectsRequestState,
    subjects,
    examsRequestState,
    exams,
    questionsRequestState,
    questions,
    errorMessage,
  ];
}
