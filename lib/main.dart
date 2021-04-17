import 'package:flutter/material.dart';
import 'package:foldable_sidebar_example/widgets/homeWidget.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context)
        .textTheme
        .apply(displayColor: Colors.white70, bodyColor: Colors.white70);
    return MaterialApp(
      title: 'Flutter Card Select and Foldable Sidebar',
      theme: ThemeData(brightness: Brightness.dark, textTheme: theme),
      home: Home(),
    );
  }
}
