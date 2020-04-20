import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flyes/utils/colors.dart';
import 'package:flyes/utils/text_styles.dart';
import 'package:image_picker/image_picker.dart';
import 'package:neumorphic/neumorphic.dart';

class MyHomePage extends StatelessWidget {
  File image;

  double imageHeight;
  double imageWidth;

  predictImage(File image) async {
    await yoloV2Tiny(image);
  }

  pickImageFromGallery() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    if (image == null) {
      return null;
    } else {
      predictImage(image);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.primary,
//      appBar: NeuAppBar(
//        title: Text('Flyes'),
//      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 60.0,
          ),
          NeuText(
            'Flyes',
            parentColor: MyColors.accent,
            style: MyTextStyles.heading,
            emboss: true,
          ),
          SizedBox(
            height: 40.0,
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
                    color: MyColors.primary,
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
                  decoration: NeumorphicDecoration(
                    color: MyColors.primary,
                    borderRadius: BorderRadius.circular(8),
                  ),
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
