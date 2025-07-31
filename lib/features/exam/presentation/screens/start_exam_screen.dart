import 'package:flutter/material.dart';
import 'package:online_exam_app_f/config/routes_manager/app_routes.dart';
import 'package:online_exam_app_f/config/theme/app_colors.dart';
import 'package:online_exam_app_f/config/theme/font_style_manager.dart';
import 'package:online_exam_app_f/config/theme/fonts_manager.dart';
import 'package:online_exam_app_f/core/utils/components/dotted_list_item.dart';
import 'package:online_exam_app_f/core/utils/constants/constants.dart';
import 'package:online_exam_app_f/features/exam/domain/model/exam_model.dart';
import 'package:online_exam_app_f/features/exam/domain/model/subject_model.dart';

class StartExamScreen extends StatelessWidget {
  SubjectModel subject;
  ExamModel exam;
  StartExamScreen({required this.exam, required this.subject, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 320,
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Row(
                  children: [
                    Image.network(
                      subject.imageUrl,
                      width: 70,
                      height: 70,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      subject.name,
                      style: getSemiBoldStyle(
                          color: AppColors.black, fontSize: FontSize.s20),
                    ),
                    Spacer(),
                    Text(
                      "${exam.duration.toString()} ${Constants.minutes}",
                      style: getMediumStyle(
                        color: AppColors.blue,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text(
                      exam.title??"",
                      style: getMediumStyle(
                          color: AppColors.black, fontSize: FontSize.s18),
                    ),
                    SizedBox(width: 5),
                    Container(
                      width: 1,
                      height: 25,
                      decoration: BoxDecoration(
                          color: AppColors.blue[30],
                          borderRadius: BorderRadius.circular(1)),
                    ),
                    SizedBox(width: 5),
                    Text(
                      "${exam.questionsNum.toString()} ${Constants.question}",
                      style:
                          getRegularStyle(color: AppColors.gray, fontSize: 16),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Divider(
            color: AppColors.blue[10],
            thickness: 2,
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  Constants.instructions,
                  style: getMediumStyle(
                      color: AppColors.black, fontSize: FontSize.s18),
                ),
                DottedListItem(),
                DottedListItem(),
                DottedListItem(),
                DottedListItem(),
                SizedBox(
                  height: 40,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        )),
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        AppRoutes.questions,
                        arguments: {
                          'exam': exam,
                          'subject': subject,
                        },
                      );
                    },
                    child: Container(
                        height: 50,
                        width: 300,
                        child: Center(
                          child: Text(
                            Constants.start,
                            style: getMediumStyle(
                                color: AppColors.white, fontSize: FontSize.s20),
                          ),
                        )))
              ],
            ),
          )
        ],
      ),
    );
  }
}
