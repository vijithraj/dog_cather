import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class image_adding extends StatefulWidget {
  const image_adding({Key? key}) : super(key: key);

  @override
  State<image_adding> createState() => _image_addingState();
}

class _image_addingState extends State<image_adding> {
  File? _image;
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Home",
          style: TextStyle(fontSize: 20, color: Colors.cyan),
        ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildImage(),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
                onPressed: () async {
                  await getimage();
                },
                child: Text("Capture image")),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
                onPressed: () {
                  _UplodeImage();
                },
                child: Text("Submit"))
          ],
        ),
      ),
    );
  }

  Future<void> getimage() async {
    XFile? image = await ImagePicker().pickImage(source: ImageSource.camera);
    setState(() {
      _image = File(image?.path as String);
      if (image != null) {
        _image = File(image.path);
      } else {
        print("no image selected");
      }
    });
  }

  Widget _buildImage() {
    return _image == null
        ? Container(
            height: 200,
            color: Colors.grey[300],
            child: Center(
              child: Text("no image selected"),
            ),
          )
        : Image.file(
            _image as File,
            height: 200,
            fit: BoxFit.cover,
          );
  }

  void _showError(String errorMessage, context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Error"),
            content: Text(errorMessage),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("Ok"))
            ],
          );
        });
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Success'),
          content: Text('Dog capture submitted successfully.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _UplodeImage() async {
    if (_image == null) return;
    List<int> imageSave = await _image!.readAsBytes();
    try {
      final filename = basename(_image!.path);
      final destination = 'images/$filename';
      final ref = firebase_storage.FirebaseStorage.instance.ref(destination);
      Uint8List uint8list = Uint8List.fromList(imageSave);
      await ref.putData(uint8list);
      final dOwnlordUrl = await ref.getDownloadURL();
      print("image upload successfully $dOwnlordUrl");
    } catch (e) {
      print(e);
    }
  }

  void clearform() {
    setState(() {
      _image = null;
    });
  }
}
