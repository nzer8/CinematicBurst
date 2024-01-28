import 'package:flutter/material.dart';
import 'package:movies/core/services/services_locator.dart';
import 'package:movies/core/utils/app_string.dart';

import 'core/utils/app_router.dart';

void main() {
  ServicesLocator().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: AppRouter.router,
      title: AppString.appName,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.grey.shade900,
        textTheme: Theme.of(context).textTheme.apply(
              bodyColor: Colors.white,
              displayColor: Colors.white,
            ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
