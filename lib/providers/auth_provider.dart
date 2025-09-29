import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();

  Future<bool> register(String username, String password) async {
    bool success = await _authService.register(username, password);
    notifyListeners();
    return success;
  }

  Future<bool> login(String username, String password) async {
    bool success = await _authService.login(username, password);
    return success;
  }
}
