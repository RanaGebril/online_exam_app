import 'package:flutter/material.dart';
import 'package:online_exam_app_f/config/routes_manager/app_routes.dart';
import 'package:online_exam_app_f/config/theme/app_colors.dart';
import 'package:online_exam_app_f/config/theme/font_style_manager.dart';
import 'package:online_exam_app_f/features/exam/domain/model/exam_model.dart';
import 'package:online_exam_app_f/features/exam/domain/model/subject_model.dart';

class ExamCard extends StatelessWidget {
  ExamModel exam;
  SubjectModel subject;
  ExamCard({required this.exam, required this.subject, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, AppRoutes.StartExam,
        arguments:   {
          'subject': subject,
          'exam': exam,
        },);
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 7, vertical: 3),
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          padding: EdgeInsets.all(7),
          height: 105,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: AppColors.black[10] ?? AppColors.gray,
                offset: Offset(4, 4),
                blurRadius: 8,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Row(
            children: [
              Image.network(subject.imageUrl, height: 100, width: 100),
              SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 200,
                    child: Row(
                      children: [
                        Text(
                          exam.title??"",
                          style: getMediumStyle(
                            color: AppColors.black,
                            fontSize: 16,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "${exam.duration.toString()} Minutes",
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
                    "${exam.questionsNum.toString()} Question",
                    style: getRegularStyle(color: AppColors.gray, fontSize: 13),
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
