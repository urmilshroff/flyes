import 'package:flutter/material.dart';
import 'package:neumorphic/neumorphic.dart';

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NeuAppBar(
        title: Text('Flyes'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              NeuCard(
                  curveType: CurveType.concave,
                  bevel: 12,
                  decoration: NeumorphicDecoration(
                      borderRadius: BorderRadius.circular(8)),
                  child: Text('Container')),
              NeuButton(
                onPressed: () {
                  print('Button pressed');
                },
                child: Text('Button'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
