import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../viewmodel/auth_viewmodel.dart';

class AuthProvider with ChangeNotifier {
  final AuthViewModel _authViewModel = AuthViewModel();
  User? _user;

  AuthProvider() {
    _user = FirebaseAuth.instance.currentUser;
  }

  User? get user => _user;
  bool get isAuthenticated => _user != null;

  get authStateChanges => null;

  Future<String?> signUp(String email, String password) async {
    String? error = await _authViewModel.signUp(email, password);
    if (error == null) {
      _user = FirebaseAuth.instance.currentUser;
      notifyListeners();
    }
    return error;
  }

  Future<String?> login(String email, String password) async {
    String? error = await _authViewModel.login(email, password);
    if (error == null) {
      _user = FirebaseAuth.instance.currentUser;
      notifyListeners();
    }
    return error;
  }
}
