class ExamModel {
  String id;
  String title;
  int questionsNum;
  int duration;

  ExamModel({
    required this.questionsNum,
    required this.id,
    required this.title,
    required this.duration});
}