import 'package:flutter/material.dart';
import 'package:online_exam_app_f/config/theme/app_colors.dart';
class NavBarIcon extends StatelessWidget {
  bool isSelrcted;
  IconData tabIcon;
   NavBarIcon({required this.isSelrcted,required this.tabIcon,super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 65,
      height: 32,
      padding: EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: isSelrcted ? AppColors.blue[10] : Colors.transparent,
        borderRadius: BorderRadius.circular(16)
      ),
      child: Icon(tabIcon, color: AppColors.blue),
    );
  }
}
