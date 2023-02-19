import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share_plus/share_plus.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({Key? key}) : super(key: key);

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  File? _image;
  final Picker = ImagePicker();

  Future getImage() async {
    final pickerimage = await Picker.pickImage(source: ImageSource.camera);
    setState(() {
      if (pickerimage != null) {
        _image = File(pickerimage.path);

      } else {
        print("No image selected");
      }
    });
  }
@override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {

    Future<void>  ShareImages() async

    {
      final pickerimage = await Picker.pickImage(source: ImageSource.camera);
      if (pickerimage != null) {
        _image = File(pickerimage.path);
        await Share.shareFiles([_image!.path]);
      } else {
        print("No image selected");
      }
    }


    return Scaffold(
      appBar: AppBar(
        title: Text("Camera Screen"),
      ),
      body: Center(
        child: Column(
          children: [
             _image ==null?Text("No image selected"): Image.file(_image!),
            InkWell(
              onTap: () => ShareImages(),
                child: Icon(Icons.share,color: Colors.orangeAccent,))
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          getImage();
        },
        child: Icon(Icons.camera_alt_rounded),
      ),
    );
  }
}
