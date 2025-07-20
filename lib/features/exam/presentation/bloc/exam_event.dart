part of 'exam_bloc.dart';

abstract class ExamEvent {}

class GetSubjectsEvent extends ExamEvent{}

class GetExamsEvent extends ExamEvent{
   String subjectID;
  GetExamsEvent(this.subjectID);
}

class GetQuestionsEvent extends ExamEvent{
  String examID;
  GetQuestionsEvent(this.examID);

}
