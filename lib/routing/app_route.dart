import 'package:flutter_frontend/routing/enum_app_page.dart';
import 'package:go_router/go_router.dart';

class AppRoute extends GoRoute {
  AppRoute({required this.page, required super.builder})
      : super(
          path: page.path,
          name: page.name,
        );

  final AppPage page;
}
