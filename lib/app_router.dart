import 'package:flutter/material.dart';
import 'views/onboarding/onboarding_screen.dart';
import 'views/auth/longin_screen.dart';
import 'views/tasks/task_list_screen.dart';
import 'views/auth/register_screen.dart';
import 'package:meuapp/views/categorys/category_list_screen.dart';

class AppRouter {
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String register = '/register';
  static const String taskList = '/tasks';
  static const String categoryList = '/categories';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => OnboardingScreen());
      case onboarding:
        return MaterialPageRoute(builder: (_) => OnboardingScreen());
      case login:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case register:
        return MaterialPageRoute(builder: (_) => RegisterScreen());
      case taskList:
        return MaterialPageRoute(builder: (_) => TaskListScreen());
      case categoryList:
        return MaterialPageRoute(builder: (_) => CategoryListScreen());
      default:
        return MaterialPageRoute(
          builder: (_) =>
              Scaffold(body: Center(child: Text('Rota não encontrada'))),
        );
    }
  }
}
