import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam_app_f/features/results/domain/usecases/get_result_usecase.dart';
import 'package:online_exam_app_f/features/results/domain/usecases/save_result_usecase.dart';
import 'package:online_exam_app_f/features/results/presentation/bloc/result_event.dart';
import 'package:online_exam_app_f/features/results/presentation/bloc/result_state.dart' show ResultState, ResultStatus;

@injectable
class ResultBloc extends Bloc<ResultEvent, ResultState> {
  final SaveResultUsecase saveResultUsecase;
  final GetResultsUsecase getResultsUsecase;

  ResultBloc(this.saveResultUsecase, this.getResultsUsecase) : super(ResultState()) {
    on<LoadResultsEvent>(_onLoadResults);
    on<SaveResultEvent>(_onSaveResult);
  }

  Future<void> _onLoadResults(LoadResultsEvent event, Emitter<ResultState> emit) async {
    emit(state.copyWith(status: ResultStatus.loading));
    try {
      final results = await getResultsUsecase();
      emit(state.copyWith(status: ResultStatus.success, completedExams: results));
    } catch (e) {
      emit(state.copyWith(status: ResultStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> _onSaveResult(SaveResultEvent event, Emitter<ResultState> emit) async {
    emit(state.copyWith(status: ResultStatus.loading));
    try {
      await saveResultUsecase(event.completedExam);
      final results = await getResultsUsecase();
      emit(state.copyWith(status: ResultStatus.success, completedExams: results));
    } catch (e) {
      emit(state.copyWith(status: ResultStatus.error, errorMessage: e.toString()));
    }
  }
}