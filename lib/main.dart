import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:online_exam_app_f/config/theme/app_theme.dart';
import 'config/di/di.dart';
import 'config/routes_manager/app_routes.dart';
import 'core/di/di.dart';
import 'core/utils/assets_manager.dart';
import 'core/utils/constants/constants.dart';
import 'features/auth/presentation/bloc/ForgotPassword/UseCase/ForgotPasswordUseCase.dart';
import 'features/auth/presentation/bloc/ForgotPassword/UseCase/verify_reset_code_use_case.dart';
import 'features/auth/presentation/bloc/ForgotPassword/UseCase/reset_password_usecase.dart';
import 'features/auth/presentation/bloc/ForgotPassword/forgot_password_bloc.dart';
import 'features/auth/presentation/bloc/ForgotPassword/VerifyCode/verify_code_bloc.dart';
import 'features/auth/presentation/bloc/ForgotPassword/ResetPassword/reset_password_bloc.dart';
import 'features/profile/data/datasources/user_local_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  configureDependencies();
  await Hive.initFlutter();
  await Hive.openBox('userBox');
  setupLocator();

  runApp(
    EasyLocalization(
      supportedLocales: [
        Locale(Constants.enLocalKey),
        Locale(Constants.arLocalKey),
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
          create: (context) => ForgotPasswordBloc(getIt<ForgotPasswordUseCase>()),
        ),
        BlocProvider(
          create: (context) => VerifyCodeBloc(getIt<VerifyResetCodeUseCase>()),
        ),
        BlocProvider(
          create: (context) => ResetPasswordBloc(getIt<ResetPasswordUseCase>()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        theme: AppTheme.lightTheme,
        locale: context.locale,
        initialRoute: isLoggedIn ? AppRoutes.profilePage : AppRoutes.login,
        routes: AppRoutes.getRoutes(),
      ),
    );
  }
}
