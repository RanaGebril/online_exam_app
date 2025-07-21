part of 'exam_bloc.dart';

abstract class ExamEvent extends Equatable {
  const ExamEvent();
  @override
  List<Object?> get props => [];
}

class GetSubjectsEvent extends ExamEvent {
  const GetSubjectsEvent(); //
}

class GetExamsEvent extends ExamEvent {
  final String subjectID;
  const GetExamsEvent(this.subjectID);

  @override
  List<Object?> get props => [subjectID];
}

class GetQuestionsEvent extends ExamEvent {
  final String examID;
  const GetQuestionsEvent(this.examID);

  @override
  List<Object?> get props => [examID];
}

class SearchSubjectsEvent extends ExamEvent {
  final String keyword;
  SearchSubjectsEvent(this.keyword);
}

class ChangeTabEvent extends ExamEvent{
  final int selectedTabIndex;
  ChangeTabEvent(this.selectedTabIndex);
}
