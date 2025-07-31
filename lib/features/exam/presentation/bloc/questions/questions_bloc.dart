import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam_app_f/config/di/di.dart';
import 'package:online_exam_app_f/features/exam/presentation/bloc/questions/questions_event.dart';
import 'package:online_exam_app_f/features/exam/presentation/bloc/questions/questions_state.dart';
import 'package:online_exam_app_f/features/results/domain/models/completed_exam.dart';
import 'package:online_exam_app_f/features/results/presentation/bloc/result_bloc.dart';
import 'package:online_exam_app_f/features/results/presentation/bloc/result_event.dart';

import '../../../domain/usecases/get_questions_usecase.dart';

@injectable
class QuestionBloc extends Bloc<QuestionEvent, QuestionState> {
  final GetQuestionsUsecase getQuestionsUsecase;

  QuestionBloc(this.getQuestionsUsecase) : super(QuestionState()) {
    on<LoadQuestionsEvent>(_onLoadQuestions);
    on<SelectAnswerEvent>(_onSelectAnswer);
    on<NextQuestionEvent>(_onNextQuestion);
    on<PreviousQuestionEvent>(_onPreviousQuestion);
    on<FinishExamEvent>(_onFinishExam);

  }

  Future<void> _onLoadQuestions(
      LoadQuestionsEvent event, Emitter<QuestionState> emit) async {
    emit(state.copyWith(status: QuestionStatus.loading));
    final result = await getQuestionsUsecase(event.exam.id);

    result.fold(
          (failure) => emit(state.copyWith(
        status: QuestionStatus.error,
        errorMessage: failure.message,
      )),
          (questions) => emit(state.copyWith(
        status: QuestionStatus.success,
        questions: questions,
        currentIndex: 0,
      )),
    );
  }

  void _onSelectAnswer(
      SelectAnswerEvent event, Emitter<QuestionState> emit) {
    final updatedAnswers = Map<String, int>.from(state.selectedAnswers);
    updatedAnswers[event.questionId] = event.selectedIndex;

    emit(state.copyWith(selectedAnswers: updatedAnswers));
  }

  void _onNextQuestion(NextQuestionEvent event, Emitter<QuestionState> emit) {
    if (state.currentIndex < state.questions.length - 1) {
      emit(state.copyWith(currentIndex: state.currentIndex + 1));
    }
  }

  void _onPreviousQuestion(
      PreviousQuestionEvent event, Emitter<QuestionState> emit) {
    if (state.currentIndex > 0) {
      emit(state.copyWith(currentIndex: state.currentIndex - 1));
    }
  }

  int calculateCorrectAnswers(QuestionState state) {
    int correct = 0;
    for (var question in state.questions) {
      final selectedIndex = state.selectedAnswers[question.id];
      if (selectedIndex != null) {
        final selectedAnswerKey = question.answers[selectedIndex].key;



        if (selectedAnswerKey == question.correctAnswer) {
          correct++;
        }
      }
    }
    return correct;
  }

  Future<void> _onFinishExam(FinishExamEvent event, Emitter<QuestionState> emit) async {
    final correctAnswers = calculateCorrectAnswers(state);
    final totalQuestions = state.questions.length;
    final completedExam = CompletedExam(
      examId: event.exam.id, // افتراض أن السؤال الأول يحتوي على examId
      completionDate: DateTime.now(),
      correctAnswers: correctAnswers,
      totalQuestions: totalQuestions,
      selectedAnswers: Map.from(state.selectedAnswers),
      subjectName: event.subject.name,
      subjectImage: event.subject.imageUrl, questionsNum: event.exam.questionsNum??20,
      duration: event.exam.duration??30
    );
    sl<ResultBloc>().add(SaveResultEvent(completedExam));
    emit(state.copyWith(correctAnswers: correctAnswers, totalQuestions: totalQuestions));
  }

}
