import 'package:academix/configs/themes/light_theme.dart';
import 'package:academix/configs/themes/mirage_theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightThemeData,
      darkTheme: mirageThemeData,
      themeMode: ThemeMode.light,
      home: const Academix(),
    ),
  );
}

class Academix extends StatelessWidget {
  const Academix({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Academix',
          style: TextStyle(fontSize: 80),
        ),
      ),
    );
  }
}
