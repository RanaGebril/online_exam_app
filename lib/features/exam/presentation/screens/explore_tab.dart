import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_exam_app_f/config/theme/app_colors.dart';
import 'package:online_exam_app_f/config/theme/font_style_manager.dart';
import 'package:online_exam_app_f/config/theme/fonts_manager.dart';
import 'package:online_exam_app_f/core/utils/components/subject_card.dart';
import 'package:online_exam_app_f/features/exam/presentation/bloc/exam_bloc.dart';
import 'package:online_exam_app_f/features/exam/presentation/bloc/exam_state.dart';

class ExploreTab extends StatelessWidget {
  ExploreTab({super.key});
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: TextFormField(
            controller: searchController,
            onChanged: (value) {
              context.read<ExamBloc>().add(SearchSubjectsEvent(value));
            },
            decoration: InputDecoration(
              hintText: "Search...",
              hintStyle: getMediumStyle(
                color: AppColors.gray,
                fontSize: FontSize.s14,
              ),
              prefixIcon: Icon(Icons.search, color: AppColors.gray),
              filled: true,
              fillColor: AppColors.white,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: BorderSide(color: AppColors.gray),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: BorderSide(color: AppColors.gray),
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
            ),
            cursorColor: AppColors.blue,
            style: getMediumStyle(color: Colors.black, fontSize: 16),
          ),
        ),
        SizedBox(height: 20),
        Padding(
          padding: EdgeInsets.all(8),
          child: Text(
            "Browse by subject",
            style: getMediumStyle(
              color: AppColors.black[100] ?? Colors.grey,
              fontSize: 18,
            ),
          ),
        ),
        Expanded(
          child: BlocConsumer<ExamBloc, ExamState>(
            listener: (context, state) {
              if (state.subjectsRequestState == RequestState.error) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.errorMessage)));
              }
            },
            builder: (context, state) {
              if (state.subjectsRequestState == RequestState.loading) {
                return Center(
                  child: CircularProgressIndicator(color: AppColors.blue),
                );
              } else if (state.subjects.isNotEmpty) {
                return ListView.builder(
                  itemCount: state.subjects.length,
                  itemBuilder: (context, index) {
                    final subject = state.subjects[index];
                    return SubjectCard(
                      subject: subject,
                      search_keyword: searchController.text,
                    );
                  },
                );
              } else {
                return Center(child: Text("No subjects"));
              }
            },
          ),
        ),
      ],
    );
  }
}
