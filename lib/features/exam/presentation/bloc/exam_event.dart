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
  final SubjectModel subjectModel;
  const GetExamsEvent(this.subjectModel);

  @override
  List<Object?> get props => [subjectModel.id];
}

class GetQuestionsEvent extends ExamEvent {
  final ExamModel examModel;
  const GetQuestionsEvent(this.examModel);

  @override
  List<Object?> get props => [examModel.id];
}

class SearchSubjectsEvent extends ExamEvent {
  final String keyword;
  SearchSubjectsEvent(this.keyword);
}

class ChangeTabEvent extends ExamEvent{
  final int selectedTabIndex;
  ChangeTabEvent(this.selectedTabIndex);
}
