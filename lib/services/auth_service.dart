import 'package:hive_flutter/hive_flutter.dart';
import '../models/user.dart';

class AuthService {
  late Box<User> _usersBox;

  AuthService() {
    _usersBox = Hive.box<User>('usersBox');
  }

  /// Registra um usuário
  Future<bool> register(String username, String password) async {
    // Verifica se já existe
    final exists = _usersBox.values.any((user) => user.username == username);
    if (exists) return false;

    final user = User(username: username, password: password);
    await _usersBox.add(user);
    return true;
  }

  /// Faz login
  Future<bool> login(String username, String password) async {
    final user = _usersBox.values.firstWhere(
      (user) => user.username == username && user.password == password,
      orElse: () => null as User,
    );
    return user != null;
  }

  /// Recupera todos os usuários (opcional, útil para debug)
  List<User> getAllUsers() {
    return _usersBox.values.toList();
  }
}
