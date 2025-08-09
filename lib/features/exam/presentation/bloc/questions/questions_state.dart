import 'package:online_exam_app_f/features/exam/domain/model/question_model.dart';
enum QuestionStatus {
  initial,
  loading,
  success,
  error,
}
class QuestionState {
  final QuestionStatus status;
  final List<QuestionModel> questions;
  final int currentIndex;
  final Map<String, int> selectedAnswers;
  final String? errorMessage;
  final int? correctAnswers;
  final int? totalQuestions;

  QuestionState({
    this.status = QuestionStatus.initial,
    this.questions = const [],
    this.currentIndex = 0,
    this.selectedAnswers = const {},
    this.errorMessage,
    this.correctAnswers,
    this.totalQuestions,
  });

  QuestionState copyWith({
    QuestionStatus? status,
    List<QuestionModel>? questions,
    int? currentIndex,
    Map<String, int>? selectedAnswers,
    String? errorMessage,
    int? correctAnswers,
    int? totalQuestions,
  }) {
    return QuestionState(
      status: status ?? this.status,
      questions: questions ?? this.questions,
      currentIndex: currentIndex ?? this.currentIndex,
      selectedAnswers: selectedAnswers ?? this.selectedAnswers,
      errorMessage: errorMessage ?? this.errorMessage,
      correctAnswers: correctAnswers ?? this.correctAnswers,
      totalQuestions: totalQuestions ?? this.totalQuestions,
    );
  }
}
