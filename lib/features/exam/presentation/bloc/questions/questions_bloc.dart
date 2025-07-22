import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam_app_f/features/exam/presentation/bloc/questions/questions_event.dart';
import 'package:online_exam_app_f/features/exam/presentation/bloc/questions/questions_state.dart';

import '../../../domain/usecases/get_questions_usecase.dart';

@injectable
class QuestionBloc extends Bloc<QuestionEvent, QuestionState> {
  final GetQuestionsUsecase getQuestionsUsecase;

  QuestionBloc(this.getQuestionsUsecase) : super(QuestionState()) {
    on<LoadQuestionsEvent>(_onLoadQuestions);
    on<SelectAnswerEvent>(_onSelectAnswer);
    on<NextQuestionEvent>(_onNextQuestion);
    on<PreviousQuestionEvent>(_onPreviousQuestion);
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
}
