import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam_app_f/features/exam/domain/model/question_model.dart';
import 'package:online_exam_app_f/features/exam/domain/model/subject_model.dart';
import 'package:online_exam_app_f/features/exam/domain/usecases/get_exam_usecase.dart';
import 'package:online_exam_app_f/features/exam/domain/usecases/get_questions_usecase.dart';
import 'package:online_exam_app_f/features/exam/domain/usecases/get_subjects_usecase.dart';
import 'package:online_exam_app_f/features/exam/presentation/bloc/exam_state.dart';

part 'exam_event.dart';

@injectable
class ExamBloc extends Bloc<ExamEvent, ExamState> {
  GetSubjectsUsecase getSubjectsUsecase;
  GetExamUsecase getExamUsecase;
  GetQuestionsUsecase getQuestionsUsecase;

  ExamBloc(this.getSubjectsUsecase,this.getExamUsecase,this.getQuestionsUsecase) : super(ExamInitial()) {
    on<GetSubjectsEvent>((event, emit) async {
      emit(state.copyWith(subjectsRequestState: RequestState.loading));
      List<SubjectModel> subjects = await getSubjectsUsecase();

      if (subjects.isNotEmpty) {
        emit(state.copyWith(
            subjectsRequestState: RequestState.success, subjects: subjects));
      }
      else {
        emit(state.copyWith(
            subjectsRequestState: RequestState.error, errorMessage: "no subjects"));
      }
    },);

    on<GetExamsEvent>((event, emit) async {
      emit(state.copyWith(examsRequestState: RequestState.loading));

      try {
        final exams = await getExamUsecase(event.subjectID);
        emit(state.copyWith(
          examsRequestState: RequestState.success,
          exams: exams,
        ));
      } catch (e) {
        emit(state.copyWith(
          examsRequestState: RequestState.error,
          errorMessage: e.toString(),
        ));
      }
    });

    on<GetQuestionsEvent>((event, emit) async{
      emit(state.copyWith(questionsRequestState: RequestState.loading));
      List<QuestionModel> questions=await getQuestionsUsecase.call(event.examID);
      if(questions.isNotEmpty){
        emit(state.copyWith(
          questionsRequestState: RequestState.success,
          questions: questions
        ));
      }
    },);

  }



}
