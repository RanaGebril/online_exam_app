import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_exam_app_f/config/theme/app_colors.dart';
import 'package:online_exam_app_f/config/theme/font_style_manager.dart';
import 'package:online_exam_app_f/config/theme/fonts_manager.dart';
import 'package:online_exam_app_f/core/utils/components/complete_exam_card.dart';
import 'package:online_exam_app_f/core/utils/constants/constants.dart';
import 'package:online_exam_app_f/features/results/presentation/bloc/result_bloc.dart';
import 'package:online_exam_app_f/features/results/presentation/bloc/result_event.dart';
import 'package:collection/collection.dart';
import '../../../../config/di/di.dart';
import '../bloc/result_state.dart';

class CompletedExamsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ResultBloc>()..add(LoadResultsEvent()),
      child: Scaffold(
        appBar: AppBar(
          title:
              Text(Constants.results, style: TextStyle(color: AppColors.blue)),
        ),
        body: BlocBuilder<ResultBloc, ResultState>(
          builder: (context, state) {
            if (state.status == ResultStatus.loading) {
              return Center(
                child: CircularProgressIndicator(color: AppColors.blue),
              );
            }
            if (state.status == ResultStatus.error) {
              return Center(
                child: Text(
                  state.errorMessage ?? Constants.errorLoadExams,
                  style: getRegularStyle(
                      color: AppColors.red, fontSize: FontSize.s16),
                ),
              );
            }
            if (state.completedExams.isEmpty) {
              return Center(
                child: Text(
                  Constants.noCompleted,
                  style: getRegularStyle(
                      color: AppColors.gray, fontSize: FontSize.s16),
                ),
              );
            }


            final examsBySubject = groupBy(state.completedExams,
                (completedExam) => completedExam.subjectName);

            return ListView(
              padding: EdgeInsets.all(8.0),
              children: examsBySubject.entries.map((entry) {
                final subjectName = entry.key;
                final exams = entry.value;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text(
                        subjectName,
                        style: getMediumStyle(
                            color: AppColors.black, fontSize: FontSize.s18),
                      ),
                    ),
                    ...exams.map((completedExam) => CompleteExamCard(completedExam: completedExam)
                    )],
                );
              }).toList(),
            );
          },
        ),
      ),
    );
  }
}