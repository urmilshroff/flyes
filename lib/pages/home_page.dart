import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flyes/utils/colors.dart';
import 'package:flyes/utils/text_styles.dart';
import 'package:image_picker/image_picker.dart';
import 'package:neumorphic/neumorphic.dart';
import 'package:tflite/tflite.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isBusy = false;

  double imageHeight;
  double imageWidth;

  File image;

  List recognitions;

  pickImageFromGallery() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    if (image == null) {
      return null;
    } else {
      predictImage(image);
    }
  }

  loadModel() async {
    Tflite.close();
    try {
      String res;
      res = await Tflite.loadModel(
        model: "assets/tflite/yolov2_tiny.tflite",
        labels: "assets/tflite/yolov2_tiny.txt",
      );

      print(res);
    } on PlatformException {
      print("Failed to load YOLO v2");
    }
  }

  predictImage(File _image) async {
    await yoloV2Tiny(_image);

    FileImage(_image)
        .resolve(ImageConfiguration())
        .addListener((ImageStreamListener((ImageInfo info, bool _) {
          setState(() {
            imageHeight = info.image.height.toDouble();
            imageWidth = info.image.width.toDouble();
          });
        })));

    setState(() {
      isBusy = false;
      image = _image;
    });
  }

  yoloV2Tiny(File image) async {
    var _recognitions = await Tflite.detectObjectOnImage(
        path: image.path,
        model: "YOLO",
        threshold: 0.3,
        imageMean: 0.0,
        imageStd: 255.0,
        numResultsPerClass: 1);

    setState(() {
      recognitions = _recognitions;
    });
  }

  List<Widget> renderBoxes(Size screen) {
    if (recognitions == null) return [];
    if (imageWidth == null || imageHeight == null) return [];

    double factorX = screen.width;
    double factorY = imageHeight / imageHeight * screen.width;

    Color blue = Colors.red;

    return recognitions.map((re) {
      return Positioned(
        left: re["rect"]["x"] * factorX,
        top: re["rect"]["y"] * factorY,
        width: re["rect"]["w"] * factorX,
        height: re["rect"]["h"] * factorY,
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(
            color: blue,
            width: 3,
          )),
          child: Text(
            "${re["detectedClass"]} ${(re["confidenceInClass"] * 100).toStringAsFixed(0)}%",
            style: TextStyle(
              background: Paint()..color = blue,
              color: Colors.white,
              fontSize: 15,
            ),
          ),
        ),
      );
    }).toList();
  }

  @override
  void initState() {
    super.initState();
    isBusy = true;

    loadModel().then((val) {
      setState(() {
        isBusy = false;
      });
    });
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
                  child: image == null
                      ? Center(child: Text('No Image!'))
                      : Image.file(image),
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
                  child: Text('Pick Image'),
                  onPressed: () {
                    pickImageFromGallery();
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
