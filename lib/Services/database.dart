import 'dart:io';
import 'package:path/path.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:proapp/Services/authentication.dart';

class DatabaseService{

  Auth _auth = new AuthService();

  static var firestore = Firestore.instance;
  //db references
  CollectionReference complaint = firestore.collection("Complaint");
  CollectionReference userDetails = firestore.collection("UserDetails");

  //get username for profile
  Future getUserName() async{
    String uid = await _auth.getCurrentUID();
    return  await userDetails.document(uid.toString()).get();
  }

  //upload to firebase storage function
  Future uploadImageToFirebase(BuildContext context,File _imageFile) async {
    String uid = await _auth.getCurrentUID();
    String fileName = basename(_imageFile.path);
    StorageReference firebaseStorageRef =
    FirebaseStorage.instance.ref().child('complaint/'+uid.toString()+'/'+fileName);
    StorageUploadTask uploadTask = firebaseStorageRef.putFile(_imageFile);
    // StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    // taskSnapshot.ref.getDownloadURL().then(
    //       (value) => print("Done: $value"),
    // );
  }
}