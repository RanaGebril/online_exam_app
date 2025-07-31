import 'package:equatable/equatable.dart';
import 'package:online_exam_app_f/features/exam/domain/model/subject_model.dart';
import '../../../domain/model/exam_model.dart';

abstract class QuestionEvent extends Equatable {
  const QuestionEvent();

  @override
  List<Object?> get props => [];
}

class LoadQuestionsEvent extends QuestionEvent {
  final ExamModel exam;

  const LoadQuestionsEvent({required this.exam});

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

class FinishExamEvent extends QuestionEvent {
  final SubjectModel subject;
  final ExamModel exam;

  const FinishExamEvent(this.subject,this.exam);

  @override
  List<Object?> get props => [subject];
}