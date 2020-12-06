import 'dart:io' as IO;
import 'package:flutter/material.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cheers2peers/controllers/ImageController.dart';
import 'package:get/get.dart';

class ImageUpload extends StatefulWidget {
  static const routeName = "/image-upload";

  @override
  _ImageUploadState createState() => _ImageUploadState();
}

class _ImageUploadState extends State<ImageUpload> {
  final controller = Get.put(ImageController());
  IO.File _imageFile;

  bool spinner = false;

  int colorButton = 0xFF39B7CD;

  Future<void> _PickImage(ImageSource source) async {
    IO.File selected = await ImagePicker.pickImage(
        source: source, maxWidth: 300, maxHeight: 300, imageQuality: 50);

    setState(() {
      _imageFile = selected;
    });
  }

  Future<void> _cropImage() async {
    IO.File cropped = await ImageCropper.cropImage(
      sourcePath: _imageFile.path,
    );

    setState(() {
      _imageFile = cropped ?? _imageFile;
    });
  }

  void _clear() {
    setState(() => _imageFile = null);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;

    final deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("Select Image to Upload"),
        centerTitle: true,
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 10.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              iconSize: 40.0,
              icon: Icon(Icons.photo_camera),
              onPressed: () => _PickImage(ImageSource.camera),
            ),
            IconButton(
              iconSize: 40.0,
              icon: Icon(Icons.photo_library),
              onPressed: () => _PickImage(ImageSource.gallery),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: ListView(
          children: <Widget>[
            if (_imageFile == null) ...[
              Padding(
                padding: EdgeInsets.only(top: deviceHeight * 0.2),
                child: Container(
                  width: deviceWidth * 0.5,
                  height: deviceHeight * 0.3,
                  child: Image.asset("assets/images/profile.png"),
                ),
              ),
              Center(
                child: Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Text(
                    "Upload your Image",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: deviceHeight * 0.02,
                    ),
                  ),
                ),
              ),
            ],
            if (_imageFile != null) ...[
              Padding(
                padding: EdgeInsets.only(top: deviceHeight * 0.1),
                child: Card(
                  color: Colors.black,
                  child: Container(
                    width: deviceWidth * 0.8,
                    height: deviceHeight * 0.5,
                    child: Image.file(_imageFile),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Column(
                    children: [
                      FlatButton(
                        child: Icon(
                          Icons.refresh,
                          size: 30.0,
                        ),
                        onPressed: _clear,
                      ),
                      Text("Remove"),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: deviceHeight * 0.02,
                  horizontal: deviceWidth * 0.2,
                ),
                child: FlatButton(
                  onPressed: () {
                    Get.find<ImageController>().imageData.value.shopImgFile =
                        _imageFile;
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Upload",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  color: Color(colorButton),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
