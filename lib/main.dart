import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_exam_app_f/config/di/di.dart';
import 'package:online_exam_app_f/config/theme/app_theme.dart';
import 'package:online_exam_app_f/config/routes_manager/app_routes.dart';
import 'package:online_exam_app_f/core/utils/assets_manager.dart';
import 'package:online_exam_app_f/core/utils/constants/constants.dart';
import 'package:online_exam_app_f/features/auth/presentation/bloc/ForgotPassword/forgot_password_bloc.dart';
import 'package:online_exam_app_f/features/exam/presentation/bloc/exam_bloc.dart';
import 'package:online_exam_app_f/features/profile/data/datasources/user_local_storage.dart';

import 'features/results/domain/models/completed_exam.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('userBox');
  Hive.registerAdapter(CompletedExamAdapter()); // لازم يكون بعد توليد الملف
  // await Hive.deleteBoxFromDisk('completed_exams');
  await Hive.openBox<CompletedExam>('completed_exams');
  setupLocator();
  runApp(
    EasyLocalization(
      supportedLocales: [
        Locale(Constants.enLocalKey),
        Locale(Constants.arLocalKey)
      ],
      path: translationsPath,
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final isLoggedIn = UserLocalStorage.isLoggedIn();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<ForgotPasswordBloc>(),
        ),
        BlocProvider(
          create: (context) => sl<ExamBloc>(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        theme: AppTheme.lightTheme,
        initialRoute: isLoggedIn ? AppRoutes.home : AppRoutes.login,
        onGenerateRoute: AppRoutes.generateRoute,
      ),
    );
  }
}