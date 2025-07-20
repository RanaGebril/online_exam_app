import 'package:flutter/material.dart';
import 'package:online_exam_app_f/features/exam/presentation/screens/exams_screen.dart';
import 'package:online_exam_app_f/features/exam/presentation/screens/subjects_screen.dart';

abstract class AppRoutes {
  static const String home = '/home';
  static const String examBySubject = '/examBySubject';
  static const String questions = '/questions';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => const SubjectsScreen());

      case examBySubject:
        final subjectId = settings.arguments as String;
        return MaterialPageRoute(
            builder: (_) => ExamsScreen(subjectId: subjectId));

      case questions:
        final examID = settings.arguments as String;
        return MaterialPageRoute(
            builder: (_) => ExamsScreen(subjectId: examID));



      default:
        return MaterialPageRoute(
            builder: (_) => const Scaffold(
              body: Center(child: Text('No route found')),
            ));
    }
  }
}
