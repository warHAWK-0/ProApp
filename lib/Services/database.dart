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

  // get myComplaints for current user stream
  Stream<QuerySnapshot> getMyComplaints(String uid){
    return complaint.document(uid).collection(uid).snapshots();
  }

  //upload Image to firebase storage function
  Future uploadImageToFirebase(BuildContext context,File _imageFile,String complaintId) async {
    String uid = await _auth.getCurrentUID();
    String fileName = basename(_imageFile.path);

    // update LOCATION field for this complaint
    await complaint.document(uid.toString()).updateData({
      'Location' : 'complaint/' + uid.toString() + '/'+ 'complaintId.jpg',
    });

    // uploading file to storage
    StorageReference firebaseStorageRef =
    FirebaseStorage.instance.ref().child('complaint/' + uid.toString() + '/'+ 'complaintId.jpg');
    firebaseStorageRef.putFile(_imageFile);

    //just to check the upload status of image and starting a task after that

    // StorageUploadTask uploadTask = firebaseStorageRef.putFile(_imageFile);
    // StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    // taskSnapshot.ref.getDownloadURL().then(
    //       (value) => print("Image Uploaded"),
    // );
  }


}