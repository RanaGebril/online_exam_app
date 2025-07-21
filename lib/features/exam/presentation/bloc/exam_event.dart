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
