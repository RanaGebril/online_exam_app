import 'package:flutter/material.dart';
import 'package:online_exam_app_f/config/routes_manager/app_routes.dart';
import 'package:online_exam_app_f/config/theme/app_colors.dart';
import 'package:online_exam_app_f/config/theme/font_style_manager.dart';
import 'package:online_exam_app_f/features/exam/domain/model/subject_model.dart';

class SubjectCard extends StatelessWidget {
  SubjectModel subject;
  String search_keyword;

   SubjectCard({required this.subject,required this.search_keyword,super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, AppRoutes.examBySubject,
            arguments: subject);
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 7, vertical: 3),
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          padding: EdgeInsets.all(7),
          height: 80,
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
              Image.network(
                subject.imageUrl,
                height: 80,
                width: 80,
              ),
              SizedBox(width: 16),
              Text(
                subject.name,
                style: getMediumStyle(
                  color: AppColors.black,
                  fontSize: 16,
                ),
              ),


            ],
          ),
        ),
      ),
    );
  }
}
