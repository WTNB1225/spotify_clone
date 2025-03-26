import 'package:flutter/material.dart';
import 'package:spotify_clone/core/configs/theme/app_theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.lightTheme,
      home: Scaffold(
        appBar: AppBar(title: Text('Hello World')),
        body: Center(child: Text('Hello World')),
      ),
    );
  }
}
