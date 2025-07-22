import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam_app_f/features/exam/domain/model/exam_model.dart';
import 'package:online_exam_app_f/features/exam/domain/model/subject_model.dart';
import 'package:online_exam_app_f/features/exam/domain/usecases/get_exam_usecase.dart';
import 'package:online_exam_app_f/features/exam/domain/usecases/get_questions_usecase.dart';
import 'package:online_exam_app_f/features/exam/domain/usecases/get_subjects_usecase.dart';
import 'package:online_exam_app_f/features/exam/domain/usecases/search_subjects_usecase.dart';
import 'package:online_exam_app_f/features/exam/presentation/bloc/exam_state.dart';

part 'exam_event.dart';

@injectable
class ExamBloc extends Bloc<ExamEvent, ExamState> {
  GetSubjectsUsecase getSubjectsUsecase;
  GetExamUsecase getExamUsecase;
  GetQuestionsUsecase getQuestionsUsecase;
  SearchSubjectsUseCase searchSubjectsUseCase;

  ExamBloc(
    this.getSubjectsUsecase,
    this.getExamUsecase,
    this.getQuestionsUsecase,
    this.searchSubjectsUseCase,
  ) : super(ExamState()) {
    on<GetSubjectsEvent>((event, emit) async {
      emit(state.copyWith(subjectsRequestState: RequestState.loading));

      final subjects = await getSubjectsUsecase();

      subjects.fold(
        (failure) {
          emit(
            state.copyWith(
              subjectsRequestState: RequestState.error,
              errorMessage: failure.message,
            ),
          );
        },
        (subjects) {
          emit(
            state.copyWith(
              subjectsRequestState: RequestState.success,
              subjects: subjects,
              allSubjects: subjects,
            ),
          );
        },
      );
    });

    on<GetExamsEvent>((event, emit) async {
      emit(state.copyWith(examsRequestState: RequestState.loading));

      final exams = await getExamUsecase(event.subjectModel.id);

      exams.fold(
        (failure) {
          emit(
            state.copyWith(
              examsRequestState: RequestState.error,
              errorMessage: failure.message,
            ),
          );
        },
        (exams) {
          emit(
            state.copyWith(
              examsRequestState: RequestState.success,
              exams: exams,
            ),
          );
        },
      );
    });

    on<GetQuestionsEvent>((event, emit) async {
      emit(state.copyWith(questionsRequestState: RequestState.loading));

      final questions = await getQuestionsUsecase(event.examModel.id);

      questions.fold(
        (failure) {
          emit(
            state.copyWith(
              questionsRequestState: RequestState.error,
              errorMessage: failure.message,
            ),
          );
        },
        (questions) {
          emit(
            state.copyWith(
              questionsRequestState: RequestState.success,
              questions: questions,
            ),
          );
        },
      );
    });

    on<SearchSubjectsEvent>((event, emit) {
      final keyword = event.keyword.toLowerCase();
      final filtered =
          state.allSubjects.where((subject) {
            return subject.name.toLowerCase().contains(keyword);
          }).toList();

      emit(state.copyWith(subjects: filtered ,searchKeyword: event.keyword));
    });

    on<ChangeTabEvent>((event, emit) {
      emit(state.copyWith(currentTabIndex: event.selectedTabIndex));
    });

  }
}
