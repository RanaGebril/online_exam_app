import 'package:equatable/equatable.dart';
import 'package:online_exam_app_f/features/results/domain/models/completed_exam.dart';

enum ResultStatus { initial, loading, success, error }

class ResultState extends Equatable {
  final ResultStatus status;
  final List<CompletedExam> completedExams;
  final String? errorMessage;

  const ResultState({
    this.status = ResultStatus.initial,
    this.completedExams = const [],
    this.errorMessage,
  });

  ResultState copyWith({
    ResultStatus? status,
    List<CompletedExam>? completedExams,
    String? errorMessage,
  }) {
    return ResultState(
      status: status ?? this.status,
      completedExams: completedExams ?? this.completedExams,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, completedExams, errorMessage];
}