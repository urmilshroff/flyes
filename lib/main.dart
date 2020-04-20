import 'package:flutter/material.dart';
import 'package:flyes/pages/home_page.dart';
import 'package:flyes/utils/colors.dart';
import 'package:neumorphic/neumorphic.dart';

void main() {
  runApp(NeumorphicApp());
}

class NeumorphicApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return NeuApp(
      theme: NeuThemeData(
        brightness: Brightness.light,
        primaryColor: MyColors.primary,
        curveType: CurveType.concave,
        lightSource: LightSource.topLeft,
      ),
      home: MyHomePage(),
    );
  }
}
