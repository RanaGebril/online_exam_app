import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_exam_app_f/config/di/di.dart';
import 'package:online_exam_app_f/config/theme/app_colors.dart';
import 'package:online_exam_app_f/config/theme/font_style_manager.dart';
import 'package:online_exam_app_f/config/theme/fonts_manager.dart';
import 'package:online_exam_app_f/core/utils/constants/constants.dart';
import 'package:online_exam_app_f/features/exam/presentation/bloc/questions/questions_bloc.dart';
import 'package:online_exam_app_f/features/exam/presentation/bloc/questions/questions_event.dart';
import 'package:online_exam_app_f/features/exam/presentation/bloc/questions/questions_state.dart';
import 'package:online_exam_app_f/features/results/domain/models/completed_exam.dart';
import 'package:online_exam_app_f/features/exam/domain/model/exam_model.dart';

class ReviewExamScreen extends StatelessWidget {
  final CompletedExam completedExam;

  const ReviewExamScreen({super.key, required this.completedExam});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<QuestionBloc>()
        ..add(LoadQuestionsEvent(exam: ExamModel(id: completedExam.examId))),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            Constants.answers
          ),elevation: 0,
        ),
        body: BlocBuilder<QuestionBloc, QuestionState>(
          builder: (context, state) {
            if (state.status == QuestionStatus.loading) {
              return Center(
                child: CircularProgressIndicator(color: AppColors.blue),
              );
            }
            if (state.status == QuestionStatus.error) {
              return Center(
                child: Text(
                  state.errorMessage ?? Constants.errorLoadQuestions,
                  style: getRegularStyle(color: AppColors.red, fontSize: FontSize.s16),
                ),
              );
            }
            if (state.questions.isEmpty) {
              return Center(
                child: Text(
                  Constants.noQuestions,
                  style: getRegularStyle(color: AppColors.gray, fontSize: FontSize.s16),
                ),
              );
            }

            final questions = state.questions;
            return Padding(
              padding: EdgeInsets.all(0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: questions.length,
                      itemBuilder: (context, index) {
                        final question = questions[index];
                        final selectedIndex = completedExam.selectedAnswers[question.id];
                        final isCorrect = selectedIndex != null &&
                            question.answers[selectedIndex].key == question.correctAnswer;

                        return Padding(padding: EdgeInsets.symmetric(horizontal: 16,vertical: 5),
                        child: Container(
                          decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow:[ BoxShadow(
                                color: AppColors.black[10] ?? AppColors.gray,
                                offset: Offset(4, 4),
                                blurRadius: 8,
                                spreadRadius: 2,
                              ),]
                          ),
                          margin: EdgeInsets.symmetric(vertical: 6.0),
                          child: Padding(padding: EdgeInsets.only(bottom: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  question.question,
                                  style: getMediumStyle(
                                    color: AppColors.black,
                                    fontSize: FontSize.s18,
                                  ),
                                ),
                              ),
                              ...List.generate(question.answers.length, (answerIndex) {
                                final answer = question.answers[answerIndex];
                                final isSelected = selectedIndex == answerIndex;
                                final isCorrectAnswer = answer.key == question.correctAnswer;

                                Color containerColor = AppColors.lightBlue;
                                if (isSelected) {
                                  containerColor = isCorrect ? AppColors.lightGreen : AppColors.lightRed;
                                } else if (isCorrectAnswer) {
                                  containerColor = AppColors.lightGreen;
                                }

                                Color containerBorderColor = AppColors.lightBlue;
                                if (isSelected) {
                                  containerColor = isCorrect ? AppColors.green : AppColors.red;
                                }

                                Color iconColor = AppColors.blue;
                                if (isSelected) {
                                  iconColor = isCorrect ? AppColors.green : AppColors.red;
                                } else if (isCorrectAnswer) {
                                  iconColor = AppColors.green;
                                }

                                return Container(
                                  margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 12),
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: containerBorderColor,

                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        isSelected || isCorrectAnswer? Icons.radio_button_checked : Icons.radio_button_off,
                                        color: iconColor,
                                      ),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: Text(
                                          answer.answer,
                                          style: getRegularStyle(
                                            color:(isSelected||isCorrectAnswer)?AppColors.blue[90]as Color:AppColors.black,
                                            fontSize: FontSize.s14,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                            ],
                          ),),
                        ),);
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}