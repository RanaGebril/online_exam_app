import 'package:equatable/equatable.dart';
import 'package:online_exam_app_f/features/results/domain/models/completed_exam.dart';

abstract class ResultEvent extends Equatable {
  const ResultEvent();
  @override
  List<Object?> get props => [];
}

class LoadResultsEvent extends ResultEvent {}
class SaveResultEvent extends ResultEvent {
  final CompletedExam completedExam;
  const SaveResultEvent(this.completedExam);
}