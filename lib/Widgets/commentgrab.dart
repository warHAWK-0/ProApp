

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proapp/Screens/SignedIn/Feed/PostLayout/comment.dart';


class CommentGrab extends StatefulWidget {
  final String pid;

  const CommentGrab({Key key, this.pid}) : super(key: key);
  @override
  _CommentGrabState createState() => _CommentGrabState();
}

class _CommentGrabState extends State<CommentGrab> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection('Post').document(widget.pid).collection('comments').snapshots(),
        builder: (context,snapshot){
          if(!snapshot.hasData){
            return SpinKitChasingDots(
              color: Colors.black,
              size: 30,
            );
          }
          else{
            return snapshot.data.documents.length ==0 ? _noCommentsFoundContainer() :
                ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
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
  Widget _noCommentsFoundContainer(){
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(top: 20),
      child: Column(
        children: [
          Container(
            width: 300.0,
            height: 300.0,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('Assets/img/no_comment.png'),
                    fit: BoxFit.fill
                )
            ),
          ),
          Text("Wow, such emptiness here. Maybe, add a comment here?",style: GoogleFonts.inter(
            textStyle:TextStyle(
              color: Color(0xff718096),
              fontSize: 12,
            ),))
        ],
      ),
    );

  }
}
