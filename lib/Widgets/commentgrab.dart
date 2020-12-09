

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:proapp/Screens/SignedIn/Feed/PostLayout/comment.dart';


class CommentGrab extends StatefulWidget {
  @override
  _CommentGrabState createState() => _CommentGrabState();
}

class _CommentGrabState extends State<CommentGrab> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection('Post').document('gbgc9NuzWGd2M0uMJ4sL').collection('comments').snapshots(),
        builder: (context,snapshot){
          if(!snapshot.hasData){
            return SpinKitChasingDots(
              color: Colors.black,
              size: 30,
            );
          }
          else{
            return snapshot.data.documents.length ==0 ? "No comments" :
                ListView.builder(
                    itemCount: snapshot.data.documents.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index){
                      return Comment(
                        name: snapshot.data.documents[index]["Name"],
                        description: snapshot.data.documents[index]["Description"],
                        date: snapshot.data.documents[index]["DateTime"]
                      );
                    }
                );
          }
        }
    );
  }
}
