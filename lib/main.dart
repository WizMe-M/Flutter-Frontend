import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_frontend/widget/page/auth_page.dart';
import 'package:flutter_frontend/widget/page/registration_page.dart';
import 'package:window_size/window_size.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    setWindowTitle('Flutter Frontend');
    setWindowMinSize(const Size(300, 400));
    setWindowMaxSize(const Size(1600, 900));
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const RegistrationPage(),
    );
  }
}
