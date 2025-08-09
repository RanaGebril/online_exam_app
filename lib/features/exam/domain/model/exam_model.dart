class ExamModel {
  String id;
  String? title;
  int? questionsNum;
  int? duration;

  ExamModel({
     this.questionsNum,
    required this.id,
     this.title,
     this.duration});
}