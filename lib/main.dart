import 'package:flutter/material.dart';
import 'package:student_management_system/pages/dashboard.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student Management System',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 0, 29, 56),
        ),
        useMaterial3: true,
        textTheme: const TextTheme(
          bodySmall: TextStyle(
            fontSize: 18,
          ),
          bodyMedium: TextStyle(
            fontSize: 22,
          ),
          displayMedium: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
          displaySmall: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
          displayLarge: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w600,
          ),
          labelSmall: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.normal,
          ),
          labelLarge: TextStyle(
            fontSize: 18,
          ),
        ),
      ),
      home: Dashboard(selectedIndex: 0),
      debugShowCheckedModeBanner: false,
    );
  }
}
