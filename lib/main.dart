import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'config/routes_manager/app_routes.dart';
import 'core/di/di.dart';
import 'core/utils/assets_manager.dart';
import 'core/utils/constants/constants.dart';
import 'features/profile/data/datasources/user_local_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  configureDependencies();
  await Hive.initFlutter();
  await Hive.openBox('userBox');
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
    final isLoggedIn = UserLocalStorage.isLoggedIn();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      initialRoute: isLoggedIn ? AppRoutes.profilePage : AppRoutes.login,
      routes: AppRoutes.getRoutes(),
    );
  }
}
