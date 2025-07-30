import 'package:flutter/material.dart';
import 'package:online_exam_app_f/config/theme/app_colors.dart';
import 'package:online_exam_app_f/config/theme/font_style_manager.dart';
import 'package:online_exam_app_f/config/theme/fonts_manager.dart';
class DottedListItem extends StatelessWidget {
  const DottedListItem({super.key});

  @override
  Widget build(BuildContext context) {

    return
      Padding(padding: EdgeInsets.only(top: 3),
      child: Text.rich(
        TextSpan(
          children: <TextSpan>[
            TextSpan(
              text: " • ",
              style: getBoldStyle(color: AppColors.gray,fontSize: FontSize.s18),
            ),
            TextSpan(
                text: 'Lorem ipsum dolor sit amet consectetur.',
                style: getMediumStyle(color: AppColors.gray,fontSize: FontSize.s14)
            ),
          ],
        ),
      ),)
    ;

  }
}
