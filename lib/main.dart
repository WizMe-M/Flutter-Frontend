import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_frontend/widget/page/auth_page.dart';
import 'package:flutter_frontend/widget/page/registration_page.dart';
import 'package:flutter_frontend/routing/app_route.dart';
import 'package:flutter_frontend/routing/enum_app_page.dart';
import 'package:go_router/go_router.dart';
import 'package:window_size/window_size.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    setWindowTitle('Flutter Frontend');
    setWindowMinSize(const Size(300, 400));
    setWindowMaxSize(const Size(1600, 900));
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final GoRouter _router = GoRouter(
    initialLocation: AppPage.signIn.path,
    routes: [
      AppRoute(
        page: AppPage.signIn,
        builder: (context, state) => const AuthPage(),
      ),
      AppRoute(
        page: AppPage.signUp,
        builder: (context, state) => const RegistrationPage(),
      )
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
