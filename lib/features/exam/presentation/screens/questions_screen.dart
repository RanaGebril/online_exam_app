import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_exam_app_f/config/routes_manager/app_routes.dart';
import 'package:online_exam_app_f/config/theme/app_colors.dart';
import 'package:online_exam_app_f/config/theme/font_style_manager.dart';
import 'package:online_exam_app_f/config/theme/fonts_manager.dart';
import 'package:online_exam_app_f/core/utils/assets_manager.dart';
import 'package:online_exam_app_f/core/utils/constants/constants.dart';
import 'package:online_exam_app_f/features/exam/domain/model/exam_model.dart';
import 'package:online_exam_app_f/features/exam/domain/model/subject_model.dart';
import 'package:online_exam_app_f/features/exam/presentation/screens/view_score_screen.dart';
import 'package:svg_flutter/svg.dart';
import '../bloc/questions/questions_bloc.dart';
import '../bloc/questions/questions_event.dart';
import '../bloc/questions/questions_state.dart';

class QuestionsScreen extends StatefulWidget {
  final ExamModel exam;
  final SubjectModel subject;

  const QuestionsScreen({super.key, required this.exam, required this.subject});

  @override
  State<QuestionsScreen> createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  late Duration remainingTime;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    remainingTime = Duration(minutes: widget.exam.duration??20);
    // remainingTime = Duration(minutes: 1);
    startTimer();
    context.read<QuestionBloc>().add(LoadQuestionsEvent(exam:widget.exam));
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingTime.inSeconds > 0) {
        setState(() {
          remainingTime = remainingTime - const Duration(seconds: 1);
        });
      } else {
        timer.cancel();

        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: AppColors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              content: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      SvgAssets.sandClock,
                      width: 45,
                      height: 85,
                    ),
                    Text(
                      Constants.timeOut,
                      style: getRegularStyle(
                          color: AppColors.red, fontSize: FontSize.s24),
                    )
                  ],
                ),
              ),
              actions: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      )),
                  onPressed: () {
                    context.read<QuestionBloc>().add(FinishExamEvent(widget.subject,widget.exam));
                    Navigator.pop(context); // أغلق الـ Dialog
                  },
                  child: Center(
                    child: Text(
                      Constants.viewScore,
                      style: getMediumStyle(
                          color: AppColors.white, fontSize: FontSize.s20),
                    ),
                  ),
                )
              ],
            );
          },
        );
      }
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  String formatTime(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    return "${twoDigits(duration.inMinutes)}:${twoDigits(duration.inSeconds % 60)}";
  }

// ... (الكود السابق حتى build)

  @override
  Widget build(BuildContext context) {
    return BlocListener<QuestionBloc, QuestionState>(
      listener: (context, state) {
        if (state.correctAnswers != null && state.totalQuestions != null) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => ViewScoreScreen(
                correctAnswers: state.correctAnswers!,
                totalQuestions: state.totalQuestions!,
              ),
            ),
          );
        }
      },
      child: BlocBuilder<QuestionBloc, QuestionState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text(Constants.exam),
              actions: [
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: Row(
                    children: [
                      Image.asset(ImagesAssets.alarm, width: 40, height: 35),
                      Padding(
                        padding: const EdgeInsets.only(right: 12.0, top: 5),
                        child: Text(
                          formatTime(remainingTime),
                          style: getRegularStyle(
                            color: AppColors.green,
                            fontSize: FontSize.s20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            body: Builder(
              builder: (context) {
                if (state.status == QuestionStatus.loading) {
                  return Center(
                    child: CircularProgressIndicator(color: AppColors.blue),
                  );
                } else if (state.status == QuestionStatus.error) {
                  return Center(
                      child: Text("${Constants.error}: ${state.errorMessage}"));
                } else if (state.questions.isEmpty) {
                  return const Center(child: Text(Constants.noQuestions));
                }

                final question = state.questions[state.currentIndex];
                final selectedAnswerIndex = state.selectedAnswers[question.id];

                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          "${Constants.question} ${state.currentIndex + 1} of ${state.questions.length}",
                          style: getMediumStyle(
                            color: AppColors.gray,
                            fontSize: FontSize.s14,
                          ),
                        ),
                      ),
                      LinearProgressIndicator(
                        value: (state.currentIndex + 1) / state.questions.length,
                        color: AppColors.blue,
                        backgroundColor: AppColors.black[10],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        question.question,
                        style: getMediumStyle(
                          color: AppColors.black,
                          fontSize: FontSize.s18,
                        ),
                      ),
                      const SizedBox(height: 16),
                      ...List.generate(question.answers.length, (index) {
                        return GestureDetector(
                          onTap: () {
                            context.read<QuestionBloc>().add(
                              SelectAnswerEvent(
                                questionId: question.id,
                                selectedIndex: index,
                              ),
                            );
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 6),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: selectedAnswerIndex == index
                                  ? AppColors.blue[10]
                                  : AppColors.lightBlue,
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  selectedAnswerIndex == index
                                      ? Icons.radio_button_checked
                                      : Icons.radio_button_off,
                                  color: AppColors.blue,
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    question.answers[index].answer,
                                    style: getRegularStyle(
                                      color:
                                      AppColors.blue[90] ?? AppColors.blue,
                                      fontSize: FontSize.s14,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                      const Spacer(),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () => context
                                  .read<QuestionBloc>()
                                  .add(PreviousQuestionEvent()),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: BorderSide(
                                    color: AppColors.blue,
                                    width: 1,
                                  ),
                                ),
                              ),
                              child: Text(
                                Constants.back,
                                style: getMediumStyle(
                                  color: AppColors.blue,
                                  fontSize: FontSize.s16,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                if (state.currentIndex ==
                                    state.questions.length - 1) {
                                  context
                                      .read<QuestionBloc>()
                                      .add(FinishExamEvent(widget.subject,widget.exam));
                                } else {
                                  context
                                      .read<QuestionBloc>()
                                      .add(NextQuestionEvent());
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.blue,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: Text(
                                state.currentIndex ==
                                    state.questions.length - 1
                                    ? Constants.finish
                                    : Constants.next,
                                style: getMediumStyle(
                                  color: AppColors.white,
                                  fontSize: FontSize.s16,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

}
