import 'answer_model.dart';

class QuestionModel {
  final String id;
  final String question;
  final List<AnswerModel> answers;
  final String? correctAnswer;
  final String? type;

  QuestionModel({
    required this.id,
    required this.question,
    required this.answers,
    this.correctAnswer,
    this.type,
  });
}
