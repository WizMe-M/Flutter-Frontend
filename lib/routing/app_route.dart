import 'package:flutter_frontend/routing/enum_app_page.dart';
import 'package:go_router/go_router.dart';

class AppRoute extends GoRoute {
  AppRoute({required this.screen, required super.builder})
      : super(
          path: screen.path,
          name: screen.name,
        );

  final AppScreen screen;
}
