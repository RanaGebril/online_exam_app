import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_exam_app_f/core/di/di.dart';
import 'package:online_exam_app_f/features/exam/presentation/bloc/exam_bloc.dart';
import 'package:online_exam_app_f/features/exam/presentation/screens/home_layout.dart';

abstract class AppRoutes {
  static const String home = '/home';
  static const String examBySubject = '/examBySubject';
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
        

      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('No route found')),
          ),
        );
    }
  }
}
