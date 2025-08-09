import 'package:equatable/equatable.dart';
import '../../../domain/model/exam_model.dart';

abstract class QuestionEvent extends Equatable {
  const QuestionEvent();

  @override
  List<Object?> get props => [];
}

class LoadQuestionsEvent extends QuestionEvent {
  final ExamModel exam;

  const LoadQuestionsEvent(this.exam);

  @override
  List<Object?> get props => [exam];
}

class SelectAnswerEvent extends QuestionEvent {
  final String questionId;
  final int selectedIndex;

  const SelectAnswerEvent({required this.questionId, required this.selectedIndex});

  @override
  List<Object?> get props => [questionId, selectedIndex];
}

class NextQuestionEvent extends QuestionEvent {}

class PreviousQuestionEvent extends QuestionEvent {}
