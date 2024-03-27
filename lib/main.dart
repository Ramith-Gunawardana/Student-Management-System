import 'package:flutter/material.dart';
import 'package:student_management_system/pages/dashboard.dart';

void main() {
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
            // primary: const Color.fromARGB(255, 0, 10, 56),
            seedColor: const Color.fromARGB(255, 0, 29, 56)),
        useMaterial3: true,
      ),
      home: const Dashboard(),
      debugShowCheckedModeBanner: false,
    );
  }
}
