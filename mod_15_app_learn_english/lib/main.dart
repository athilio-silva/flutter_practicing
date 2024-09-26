import 'package:flutter/material.dart';
import 'package:mod_15_app_learn_english/src/screens/home_screen.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Aprenda Inglês',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.brown,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xff795548),
          foregroundColor: Colors.white,
        ),
        scaffoldBackgroundColor: const Color(0xfff5e9b9),
      ),
      home: const HomeScreen(),
    );
  }
}
