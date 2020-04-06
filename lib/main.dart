import 'package:flutter/material.dart';
import 'package:flyes/utils/colors.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flyes',
      theme: ThemeData(
        primaryColor: MyColors.primary,
        accentColor: MyColors.accent,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: null,
    );
  }
}
