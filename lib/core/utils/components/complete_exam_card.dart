import 'package:flutter/material.dart';
import 'package:online_exam_app_f/config/routes_manager/app_routes.dart';
import 'package:online_exam_app_f/config/theme/app_colors.dart';
import 'package:online_exam_app_f/config/theme/font_style_manager.dart';
import 'package:online_exam_app_f/config/theme/fonts_manager.dart';
import 'package:online_exam_app_f/features/results/domain/models/completed_exam.dart';

class CompleteExamCard extends StatelessWidget {
  CompletedExam completedExam;
   CompleteExamCard({required this.completedExam,super.key});


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, AppRoutes.review,
            arguments: completedExam);
      },
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: 7, vertical: 3),
        child: Container(
          margin: EdgeInsets.symmetric(
              vertical: 5, horizontal: 5),
          padding: EdgeInsets.all(7),
          height: 105,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color:
                AppColors.black[10] ?? AppColors.gray,
                offset: Offset(4, 4),
                blurRadius: 8,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Row(
            children: [
              Image.network(completedExam.subjectImage,
                  height: 100, width: 100),
              SizedBox(width: 16),
              Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 180,
                    child: Row(
                      children: [
                        Text(
                          completedExam.subjectName,
                          style: getMediumStyle(
                            color: AppColors.black,
                            fontSize: 16,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "${completedExam.duration.toString()} Minutes",
                          style: getMediumStyle(
                            color: AppColors.blue,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 3),
                  Text(
                    "${completedExam.questionsNum.toString()} Question",
                    style: getRegularStyle(
                        color: AppColors.gray,
                        fontSize: 13),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "${completedExam.correctAnswers.toString()} corrected answers",
                    style: getSemiBoldStyle(
                        color: AppColors.blue,
                        fontSize: FontSize.s12),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
