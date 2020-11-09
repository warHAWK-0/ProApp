import 'dart:io';
import 'package:path/path.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:proapp/Services/authentication.dart';

class DatabaseService{
  final BaseAuth baseAuth;

  DatabaseService(this.baseAuth);

  //db location for COMPLAINT table
  CollectionReference complaintRef = Firestore.instance.collection("Complaint");

  //upload to firebase storage function
  Future uploadImageToFirebase(BuildContext context,File _imageFile) async {
    String fileName = basename(_imageFile.path);
    StorageReference firebaseStorageRef =
    FirebaseStorage.instance.ref().child('complaint/'+baseAuth.currentUser().toString()+'/'+fileName);
    StorageUploadTask uploadTask = firebaseStorageRef.putFile(_imageFile);
    // StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    // taskSnapshot.ref.getDownloadURL().then(
    //       (value) => print("Done: $value"),
    // );
  }
}