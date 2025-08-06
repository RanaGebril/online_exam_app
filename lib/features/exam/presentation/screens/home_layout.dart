import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_exam_app_f/config/theme/app_colors.dart';
import 'package:online_exam_app_f/core/utils/components/nav_bar_icon.dart';
import 'package:online_exam_app_f/core/utils/constants/constants.dart';
import 'package:online_exam_app_f/features/exam/presentation/bloc/exam_bloc.dart';
import 'package:online_exam_app_f/features/exam/presentation/bloc/exam_state.dart';
import 'package:online_exam_app_f/features/exam/presentation/screens/explore_tab.dart';
import 'package:online_exam_app_f/features/exam/presentation/screens/start_exam_screen.dart';

import '../../../profile/presentation/pages/profile_page.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({super.key});

  @override
  State<HomeLayout> createState() => _HomeLayout();
}

class _HomeLayout extends State<HomeLayout> {
  @override
  void initState() {
    super.initState();
    context.read<ExamBloc>().add(GetSubjectsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExamBloc, ExamState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title:
                Text(Constants.survey, style: TextStyle(color: AppColors.blue)),
          ),
          body: tabs[state.currentTabIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: state.currentTabIndex,
            onTap: (index) {
              context.read<ExamBloc>().add(ChangeTabEvent(index));
            },
            items: [
              BottomNavigationBarItem(
                icon: NavBarIcon(
                  isSelrcted: state.currentTabIndex == 0,
                  tabIcon: Icons.home_outlined,
                ),
                label: Constants.explore,
              ),
              BottomNavigationBarItem(
                icon: NavBarIcon(
                  isSelrcted: state.currentTabIndex == 1,
                  tabIcon: Icons.assignment,
                ),
                label: Constants.results,
              ),
              BottomNavigationBarItem(
                icon: NavBarIcon(
                  isSelrcted: state.currentTabIndex == 2,
                  tabIcon: Icons.person_outline,
                ),
                label: Constants.profile,
              ),
            ],
          ),
        );
      },
    );
  }

  List<Widget> tabs = [ExploreTab(), ProfilePage(), ProfilePage()];
}
