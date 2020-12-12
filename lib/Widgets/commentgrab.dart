

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proapp/Models/Comment.dart';
import 'package:proapp/Screens/SignedIn/Feed/PostLayout/comment.dart';


class CommentGrab extends StatefulWidget {
  final String pid,uid;

  const CommentGrab({Key key, this.pid,this.uid}) : super(key: key);
  @override
  _CommentGrabState createState() => _CommentGrabState();
}

class _CommentGrabState extends State<CommentGrab> {
  Comment c =new Comment();
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
                      if(snapshot.data.documents[index]["FlaggedUid"].length<2) { //TODO: change it to 5% of the user base
                        bool initialflag=false;
                        if (snapshot.data.documents[index]["FlaggedUid"].contains(widget.uid))
                          {initialflag=true;}
                        return Comment(
                          comment: CommentModel(
                            name: snapshot.data.documents[index]["Name"],
                            date: snapshot.data.documents[index]["DateTime"],
                            commentdes: snapshot.data
                                .documents[index]["Description"],
                            flaggedUid: snapshot.data
                                .documents[index]["FlaggedUid"],
                          ),
                          pid: widget.pid,
                          cid: snapshot.data.documents[index].documentID,
                          uid: widget.uid,
                          initialflag: initialflag,
                        );
                      }
                      else{
                        return Container();
                      }
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
