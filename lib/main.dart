import 'package:fltr_test_app/home_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const Main());
}

/// This widget is the root of this application.
class Main extends StatelessWidget {
  ///Empty constructor
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(
        title: 'Color Changing App',
      ),
    );
  }
}
