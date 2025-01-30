import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:notes_app/firebase_options.dart';
import 'package:provider/provider.dart';
import 'view/login_screen.dart';
import 'view/home_screen.dart';
import 'viewmodel/auth_viewmodel.dart';
import 'viewmodel/note_viewmodel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthViewModel>(create: (_) => AuthViewModel()),
        Provider<NoteViewModel>(create: (_) => NoteViewModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(),
        home: AuthChecker(),
      ),
    );
  }
}

class AuthChecker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context, listen: false);

    return StreamBuilder(
      stream: authViewModel.authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (snapshot.hasData) {
          return HomeScreen();
        }
        return LoginScreen();
      },
    );
  }
}
