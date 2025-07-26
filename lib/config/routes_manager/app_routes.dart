import 'package:flutter/material.dart';
import '../../features/auth/presentation/bloc/ForgotPassword/forget_password_flow.dart';
import '../../features/auth/presentation/bloc/login/login_page.dart';
import '../../features/auth/presentation/bloc/signup/sinup_page.dart';
import '../../features/profile/presentation/pages/Resetpassword/reset_password.dart';
import '../../features/profile/presentation/pages/profile_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_exam_app_f/core/di/di.dart';
import 'package:online_exam_app_f/features/exam/domain/model/exam_model.dart';
import 'package:online_exam_app_f/features/exam/domain/model/subject_model.dart';
import 'package:online_exam_app_f/features/exam/presentation/bloc/exam_bloc.dart';
import 'package:online_exam_app_f/features/exam/presentation/bloc/questions/questions_bloc.dart';
import 'package:online_exam_app_f/features/exam/presentation/screens/home_layout.dart';
import 'package:online_exam_app_f/features/exam/presentation/screens/exams_screen.dart';
import 'package:online_exam_app_f/features/exam/presentation/screens/questions_screen.dart';
import 'package:online_exam_app_f/features/exam/presentation/screens/start_exam_screen.dart';
import 'package:online_exam_app_f/features/exam/presentation/screens/view_score_screen.dart';
import '../../features/exam/presentation/bloc/questions/questions_event.dart';

abstract class AppRoutes {
  static const String login = '/login';
  static const String signup = '/signup';
  static const String forgetpass = '/forgetpass';
  static const String profilePage = '/profile';
  static const String resetpassword = '/resetpassword';
  static const String home = '/home';
  static const String examBySubject = '/examBySubject';
  static const String StartExam = '/StartExam';
  static const String questions = '/questions';
  static const String viewScore = "/viewScore";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(
          builder: (_) => LoginPage(),
        );

      case signup:
        return MaterialPageRoute(
          builder: (_) => SignupPage(),
        );

      case forgetpass:
        return MaterialPageRoute(
          builder: (_) => const ForgetPasswordFlow(),
        );

      case profilePage:
        return MaterialPageRoute(
          builder: (_) => ProfilePage(),
        );

      case resetpassword:
        return MaterialPageRoute(
          builder: (_) => ResetPassword(),
        );

      case home:
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create: (context) => getIt<ExamBloc>(),
                child: const HomeLayout(),
              ),
        );

      case AppRoutes.examBySubject:
        final subjectModel = settings.arguments as SubjectModel;
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create:
                    (context) =>
                        getIt<ExamBloc>()..add(GetExamsEvent(subjectModel)),
                child: ExamsScreen(subject: subjectModel),
              ),
        );

      case AppRoutes.StartExam:
        final args = settings.arguments as Map<String, dynamic>;
        final subjectModel = args['subject'] as SubjectModel;
        final examModel = args['exam'] as ExamModel;
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create: (context) => getIt<ExamBloc>(),
                child: StartExamScreen(subject: subjectModel, exam: examModel),
              ),
        );

      case AppRoutes.questions:
        final args = settings.arguments as Map<String, dynamic>;
        final exam = args['exam'] as ExamModel;
        final subject = args['subject'] as SubjectModel;

        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create:
                    (context) =>
                        getIt<QuestionBloc>()..add(LoadQuestionsEvent(exam)),
                child: QuestionsScreen(exam: exam, subject: subject),
              ),
        );

      case AppRoutes.viewScore:
        final args = settings.arguments as Map<String, dynamic>;
        final correctAnswers = args['correctAnswers'] as int;
        final totalQuestions = args['totalQuestions'] as int;

        return MaterialPageRoute(
          builder:
              (_) => ViewScoreScreen(
                correctAnswers: correctAnswers,
                totalQuestions: totalQuestions,
              ),
        );

      default:
        return MaterialPageRoute(
          builder:
              (_) =>
                  const Scaffold(body: Center(child: Text('No route found'))),
        );
    }
  }
}