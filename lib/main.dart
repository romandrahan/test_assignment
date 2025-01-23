import 'package:flutter/material.dart';
import 'package:test_assignment/features/authentication/screens/auth_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: const ColorScheme.light(primary: Color(0xFF4B65FF)),
        useMaterial3: true,
        textTheme: Typography.material2014().black.apply(
              bodyColor: const Color(0xFF4A4E71),
              displayColor: Colors.red,
            ),
      ),
      home: const AuthScreen(),
    );
  }
}
