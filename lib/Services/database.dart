import 'dart:io';
import 'package:path/path.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:proapp/Models/UserDetails.dart';
import 'package:proapp/Services/authentication.dart';

class DatabaseService{
  final String uid;
  DatabaseService({@required this.uid});
  Auth _auth = new AuthService();

  static var firestore = Firestore.instance;
  //db references
  CollectionReference myComplaint() => firestore.collection("Complaint").document("MyComplaint").collection(uid);
  CollectionReference allComplaint(String pincode) => firestore.collection("Complaint").document("AllComplaint").collection(pincode);
  CollectionReference userDetails = firestore.collection("UserDetails");
  CollectionReference allComplaints = firestore.collection("AllComplaints");
  CollectionReference post = firestore.collection("Post");


  //get username for profile
  Future getUserName() async{
    String uid = await _auth.getCurrentUID();
    return  await userDetails.document(uid.toString()).get();
  }

  // get myComplaints for current user stream
  Stream<QuerySnapshot> getMyComplaints(String uid){
    return myComplaint().snapshots();
  }

  //upload Image to firebase storage function
  Future uploadImageToFirebase(BuildContext context,File _imageFile,String complaintId) async {
    String uid = await _auth.getCurrentUID();
    String fileName = basename(_imageFile.path);
    // uploading file to storage
    StorageReference firebaseStorageRef =
    FirebaseStorage.instance.ref().child('complaint/' + uid.toString() + '/'+ complaintId+'.jpg');
    firebaseStorageRef.putFile(_imageFile);

  }

   Future updateUserDB(UserDetails details) async {
     String uid = await _auth.getCurrentUID();
    return await userDetails
        .document(uid.toString())
        .updateData({
      'verified' : details.verified,
      'mobileNo' : details.mobileNo,
      'address' : details.address,
    });
  }
}