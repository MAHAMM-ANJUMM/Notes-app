import 'package:firebase_auth/firebase_auth.dart';

class AuthViewModel {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // This stream provides the authentication state (signed in or signed out)
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // Sign Up
  Future<String?> signUp(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return null; // No error, signup successful
    } catch (e) {
      return e.toString(); // Return error message
    }
  }

  // Login
  Future<String?> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return null; // No error, login successful
    } catch (e) {
      return e.toString(); // Return error message
    }
  }

  // Logout
  Future<void> logout() async {
    await _auth.signOut();
  }
}
