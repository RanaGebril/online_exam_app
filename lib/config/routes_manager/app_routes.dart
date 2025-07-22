import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_exam_app_f/core/di/di.dart';
import 'package:online_exam_app_f/features/exam/domain/model/exam_model.dart';
import 'package:online_exam_app_f/features/exam/domain/model/question_model.dart';
import 'package:online_exam_app_f/features/exam/domain/model/subject_model.dart';
import 'package:online_exam_app_f/features/exam/presentation/bloc/exam_bloc.dart';
import 'package:online_exam_app_f/features/exam/presentation/screens/home_layout.dart';
import 'package:online_exam_app_f/features/exam/presentation/screens/exams_screen.dart';
import 'package:online_exam_app_f/features/exam/presentation/screens/questions_screen.dart';
import 'package:online_exam_app_f/features/exam/presentation/screens/start_exam_screen.dart';

abstract class AppRoutes {
  static const String home = '/home';
  static const String examBySubject = '/examBySubject';
  static const String StartExam = '/StartExam';
  static const String questions = '/questions';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<ExamBloc>(),
            child: const HomeLayout(),
          ),
        );

      case AppRoutes.examBySubject:
        final subjectModel = settings.arguments as SubjectModel;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) =>
            getIt<ExamBloc>()..add(GetExamsEvent(subjectModel)),
            child: ExamsScreen(subject: subjectModel,),
          ),
        );

      case AppRoutes.StartExam:
        final args = settings.arguments as Map<String, dynamic>;
        final subjectModel = args['subject'] as SubjectModel;
        final examModel = args['exam'] as ExamModel;
        return MaterialPageRoute(
            builder: (_) =>  BlocProvider(
              create: (context) =>
              getIt<ExamBloc>(),
              child: StartExamScreen(subject: subjectModel,exam: examModel,),
            ),);


      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('No route found')),
          ),
        );
    }
  }
}
