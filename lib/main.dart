import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'core/di/di.dart';
import 'core/utils/assets_manager.dart';
import 'core/utils/constants/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  configureDependencies();
  runApp(
    EasyLocalization(
      supportedLocales: [Locale(Constants.enLocalKey), Locale(Constants.arLocalKey)],
      path: translationsPath,
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      // initialRoute: AppRoutes.login,
      // routes: AppRoutes.getRoutes(),
    );
  }
}
