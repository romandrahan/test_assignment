import 'package:flutter/material.dart';
import 'package:test_assignment/features/authentication/presentation/auth_form_colors.dart';
import 'package:test_assignment/features/authentication/presentation/screens/auth_screen.dart';

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
              decorationColor: const Color(0xFF6F91BC),
            ),
        extensions: const [
          AuthFormColors(
            validGreen: Color(0xFF27B274),
            invalidRed: Color(0xFFFF8080),
            invalidLightRed: Color(0xFFFDEFEE),
          ),
        ],
      ),
      home: const AuthScreen(),
    );
  }
}
