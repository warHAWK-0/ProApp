import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase/firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:proapp/Services/authentication.dart';

class DatabaseService{
  final BaseAuth _baseAuth;


  DatabaseService(this._baseAuth);

  CollectionReference complaint = Firestore.instance.collection("Complaint");

  // Future<Widget> _getImage(BuildContext context, String image) async {
  //   Image m;
  //   await FireStorageService.loadFromStorage(context, image).then((downloadUrl) {
  //     m = Image.network(
  //       downloadUrl.toString(),
  //       fit: BoxFit.scaleDown,
  //     );
  //   });
  //
  //   return m;
  // }

  Future<File> pickImagePath() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    return File(pickedFile.path);
  }
}