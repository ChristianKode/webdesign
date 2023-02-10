import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker_web/image_picker_web.dart';

class ImageUploadScreen extends StatefulWidget {
  @override
  _ImageUploadScreenState createState() => _ImageUploadScreenState();
}

class _ImageUploadScreenState extends State<ImageUploadScreen> {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  List<File> _images = [];

  void _openFilePicker() async {
      _images = await ImagePickerWeb.getMultiImagesAsFile() as List<File>;
  }

  void _uploadImages() async {
    for (int i = 0; i < _images.length; i++) {
      String fileName = "${DateTime.now().millisecondsSinceEpoch}.jpg";
      Reference reference = _storage.ref().child(fileName);
      UploadTask uploadTask = reference.putFile(_images[i]);
      await uploadTask;
    }
    setState(() {
      _images = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Upload Images"),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _images.length,
              itemBuilder: (context, index) {
                return Image.file(_images[index]);
              },
            ),
          ),
          ElevatedButton(
            child: Text("Add Image"),
            onPressed: _openFilePicker,
          ),
          ElevatedButton(
            child: Text("Upload Images"),
            onPressed: _images.length > 0 ? _uploadImages : null,
          ),
        ],
      ),
    );
  }
}