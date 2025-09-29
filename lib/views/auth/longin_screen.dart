import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../app_router.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      backgroundColor: Colors.black87,
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(controller: usernameController, decoration: InputDecoration(labelText: 'Usuário')),
            TextField(controller: passwordController, decoration: InputDecoration(labelText: 'Senha'), obscureText: true),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                bool success = await authProvider.login(usernameController.text, passwordController.text);
                if (success) {
                  Navigator.pushReplacementNamed(context, AppRouter.taskList);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Usuário ou senha incorretos')));
                }
              },
              child: Text("Login"),
            ),
            TextButton(onPressed: () => Navigator.pushNamed(context, AppRouter.register), child: Text("Registrar")),
          ],
        ),
      ),
    );
  }
}
