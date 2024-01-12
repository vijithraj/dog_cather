import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import 'User_UI.dart';


class Gps_page extends StatefulWidget {
  const Gps_page({Key? key}) : super(key: key);

  @override
  State<Gps_page> createState() => _Gps_pageState();
}

class _Gps_pageState extends State<Gps_page> {
  late Position? _currentPosition;
  File? _image;
  TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.black,
        onPressed: (){
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder:
                  (context) =>


                  HomePage() ));
        },),
        title: Text('Dog Capture'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildImagePreview(),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () async {
                  await _getImage();
                },
                child: Text('Capture Image'),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () async {
                  await _checkLocationPermissionAndGetCurrentLocation();
                },
                child: Text('Get Location'),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  _submitDogCapture();
                },
                child: Text('Submit Dog Capture'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImagePreview() {
    return _image == null
        ? Container(
      height: 200.0,
      color: Colors.grey[300],
      child: Center(
        child: Text('No image selected.'),
      ),
    )
        : Image.file(_image as File, height: 200.0, fit: BoxFit.cover);
  }

  Future<void> _getImage() async {
    XFile? image = await ImagePicker().pickImage(source: ImageSource.camera);
    setState(() {
      _image = File(image?.path as String);
    });
  }

  Future<void> _checkLocationPermissionAndGetCurrentLocation() async {
    var status = await Permission.locationWhenInUse.status;
    if (status.isGranted) {
      await _getCurrentLocation();
    } else {
      await Permission.locationWhenInUse.request();
    }
  }

  Future<void> _getCurrentLocation() async {
    if (await Geolocator.isLocationServiceEnabled()) {
      try {
        Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );

        setState(() {
          _currentPosition = position;
        });
      } catch (e) {
        print('Error getting location: $e');
      }
    } else {
      print('Location services are not enabled.');
    }
  }

  void _submitDogCapture() async {
    try {
      if (_image == null) {
        _showErrorDialog('Please capture an image.');
        return;
      }

      if (_currentPosition == null) {
        _showErrorDialog('Location not available.');
        return;
      }

      String description = _descriptionController.text;

      String imageUrl = await _uploadImageToStorage();

      await FirebaseFirestore.instance.collection('dog_captures').add({
        'image_url': imageUrl,
        'latitude': _currentPosition?.latitude,
        'longitude': _currentPosition?.longitude,
        'description': description,
        'timestamp': FieldValue.serverTimestamp(),
      });

      _showSuccessDialog();
      _clearForm();
    } catch (e) {
      print('Error submitting dog capture: $e');
      _showErrorDialog('An error occurred while submitting the dog capture.');
    }
  }

  Future<String> _uploadImageToStorage() async {
    // Implement your image upload logic here
    return ''; // Replace with the actual image URL
  }

  void _showSuccessDialog() {
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

  void _showErrorDialog(String errorMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(errorMessage),
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

  void _clearForm() {
    setState(() {
      _image = null;
      _currentPosition = null;
      _descriptionController.clear();
    });
  }
}