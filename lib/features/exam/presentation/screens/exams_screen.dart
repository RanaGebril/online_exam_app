import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_exam_app_f/core/utils/components/exam_card.dart';
import 'package:online_exam_app_f/features/exam/domain/model/exam_model.dart';
import 'package:online_exam_app_f/features/exam/domain/model/subject_model.dart';
import 'package:online_exam_app_f/features/exam/presentation/bloc/exam_bloc.dart';
import 'package:online_exam_app_f/config/theme/app_colors.dart';
import 'package:online_exam_app_f/features/exam/presentation/bloc/exam_state.dart';

class ExamsScreen extends StatelessWidget {
  SubjectModel subject;

   ExamsScreen({super.key, required this.subject});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(subject.name)),
      body:   BlocConsumer<ExamBloc,ExamState>(
        builder: (context, state) {
          if (state.examsRequestState == RequestState.loading) {
            return Center(
              child: CircularProgressIndicator(color: AppColors.blue),
            );
          }
          else if(state.examsRequestState==RequestState.success){
            return  ListView.builder(
                itemCount: state.exams.length,
                itemBuilder: (context, index) {
                  return ExamCard(
                    exam: state.exams[index],
                    subject: subject,
                  );
                },
              );
          }
          else{
            return Center(child: Text("no exams for this subject"),);
          }
        }
        , listener: (context, state) {
        if(state.examsRequestState==RequestState.error){
          ScaffoldMessenger.of(context).
          showSnackBar(SnackBar(content: Text(state.errorMessage)));
        }
      },),
    );
}}