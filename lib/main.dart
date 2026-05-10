import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(AutoCareApp());
}

class AutoCareApp extends StatelessWidget {
  const AutoCareApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AutoCare',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      home: const HomeScreen(),
    );
  }
}
