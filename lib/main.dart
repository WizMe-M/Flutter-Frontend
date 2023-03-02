import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_frontend/model/user.dart';
import 'package:flutter_frontend/widget/screen/home_screen.dart';
import 'package:flutter_frontend/widget/screen/auth_screen.dart';
import 'package:flutter_frontend/widget/screen/registration_screen.dart';
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
    initialLocation: AppScreen.signIn.path,
    routes: [
      AppRoute(
        screen: AppScreen.signIn,
        builder: (context, state) => const AuthScreen(),
      ),
      AppRoute(
        screen: AppScreen.signUp,
        builder: (context, state) => const RegistrationScreen(),
      ),
      AppRoute(
        screen: AppScreen.home,
        builder: (context, state) =>
            HomeScreen(authorized: state.extra as User),
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
