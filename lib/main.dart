import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'app_router.dart';
import 'providers/auth_provider.dart';
import 'providers/task_provider.dart';
import 'providers/category_provider.dart';
import 'models/user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  // Registrando o adapter do User
  Hive.registerAdapter(UserAdapter());

  // Abrindo boxes
  await Hive.openBox<User>('usersBox'); // Box de usuários
  await Hive.openBox('tasksBox');       // Box de tarefas
  await Hive.openBox('categoriesBox');  // Box de categorias

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => TaskProvider()),
        ChangeNotifierProvider(create: (_) => CategoryProvider()),
      ],
      child: MaterialApp(
        title: 'Task Manager',
        theme: ThemeData(primarySwatch: Colors.blue),
        initialRoute: AppRouter.onboarding, // ou AppRouter.splash se houver splash
        onGenerateRoute: AppRouter.generateRoute,
      ),
    );
  }
}
