import 'package:flutter/material.dart';
import 'package:flyes/utils/colors.dart';
import 'package:neumorphic/neumorphic.dart';

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.accent,
      appBar: NeuAppBar(
        title: Text('Flyes'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 50.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 150.0,
                width: 150.0,
                child: NeuCard(
                  curveType: CurveType.flat,
                  bevel: 12,
                  decoration: NeumorphicDecoration(
                    color: MyColors.accent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              SizedBox(
                width: 15.0,
              ),
              Container(
                height: 150.0,
                width: 150.0,
                child: NeuButton(
                  shape: BoxShape.circle,
                  onPressed: () {
                    print('Button pressed');
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
