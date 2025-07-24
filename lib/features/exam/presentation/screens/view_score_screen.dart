import 'package:flutter/material.dart';
import 'package:online_exam_app_f/config/theme/app_colors.dart';
import 'package:online_exam_app_f/config/theme/font_style_manager.dart';
import 'package:online_exam_app_f/config/theme/fonts_manager.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class ViewScoreScreen extends StatelessWidget {
  final int correctAnswers;
  final int totalQuestions;

  const ViewScoreScreen({
    super.key,
    required this.correctAnswers,
    required this.totalQuestions,
  });

  @override
  Widget build(BuildContext context) {
    final wrongAnswers = totalQuestions - correctAnswers;
    final correctPercentage = correctAnswers / totalQuestions;
    final wrongPercentage = wrongAnswers / totalQuestions;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Exam Score"),
      ),
      body: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Your Score",
                style: getMediumStyle(
                  color: AppColors.black,
                  fontSize: FontSize.s20,
                ),
              ),
              SizedBox(height: 20,),
              Row(
                children: [
                  CircularPercentIndicator(
                    radius: 60.0,
                    lineWidth: 5,
                    percent: correctPercentage,
                    center: Text(
                      "${(correctPercentage * 100).toStringAsFixed(0)}%",
                      style: getMediumStyle(
                        color: AppColors.black[50]??AppColors.black,
                        fontSize: FontSize.s20,
                      ),
                    ),
                    progressColor: AppColors.blue,
                    backgroundColor: AppColors.red,
                    animation: true,
                    animationDuration: 1000,
                  ),


                  SizedBox(width: 40,),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Correct",style: getMediumStyle(color: AppColors.blue,fontSize: FontSize.s16),),
                      SizedBox( height: 10,),
                      Text("Incorrect",style: getMediumStyle(color: AppColors.red,fontSize: FontSize.s16)),
                    ],
                  ),
                  SizedBox(width: 40,),
                  Column(
                    children: [
                          Container(
                            height: 25,
                            width: 25,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.white,
                                border: Border.all(
                                    width: 1,
                                  color: AppColors.blue
                                )
                            ),
                            child:Center(child:  Text(
                              correctAnswers.toString(),style: getMediumStyle(color: AppColors.blue,fontSize: FontSize.s13),
                            ),)

                          ),
                          SizedBox(height: 10,),
                          Container(
                              height: 25,
                              width: 25,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.white,
                                  border: Border.all(
                                      width: 1,
                                      color: AppColors.red
                                  )
                              ),
                              child:Center(
                                child:  Text(
                                  wrongAnswers.toString(),style: getMediumStyle(color: AppColors.red,fontSize: FontSize.s13),
                                ),


                          ),
                          )
                    ],
                  )
                ],
              ),

              SizedBox(height: 50,),

              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      )

                  ),
                  onPressed: () {


                  },
                  child:
                  Text("Show results",
                    style: getMediumStyle(color: AppColors.white,
                        fontSize: FontSize.s16),
                  ),
              ),
              SizedBox(height: 20,),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.white,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: AppColors.blue,
                          width: 1
                        ),
                        borderRadius: BorderRadius.circular(25),
                      )

                  ),
                  onPressed: () {


                  },
                  child:
                   Text("Start again",
                    style: getMediumStyle(color: AppColors.blue,
                        fontSize: FontSize.s16),
                  )
              )


                ],
              ),

    ));
  }}
