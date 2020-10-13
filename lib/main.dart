import 'dart:io';

import 'package:compressimage/compressimage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

//ikuti tutorial iini untuk setup ke IOS
//https://www.youtube.com/watch?v=gkYQKFE0Fmk

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<File> _futureImage;
  File _imageFile;

  Future getImage() async {
    _futureImage = ImagePicker.pickImage(source: ImageSource.camera);
    _imageFile = await _futureImage;
    print("FILE SIZE BEFORE: " + _imageFile.lengthSync().toString());
    await CompressImage.compress(
        imageSrc: _imageFile.path,
        desiredQuality: 80); //desiredQuality ranges from 0 to 100
    print("FILE SIZE  AFTER: " + _imageFile.lengthSync().toString());

    setState(() {
      _imageFile;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Image From Camera"),
        ),
        body: Center(
          child: ListView(children: [
            _imageFile == null
                ? Text("Silahkan ambil gambar")
                : Image.file(_imageFile),
            Text("Path : " +
                _imageFile.toString().substring(6).replaceAll("'", "")),
          ]),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: getImage,
          tooltip: "Pick Image",
          child: Icon(Icons.camera),
        ),
      ),
    );
  }
}
