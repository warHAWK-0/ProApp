import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proapp/Models/Comment.dart';
import 'package:proapp/Widgets/themes.dart';

class Comment extends StatefulWidget {
  final bool initialflag;
  final CommentModel comment;
  final String pid,cid,uid; // pid- post, cid - comment , uid - user

  const Comment({Key key, this.comment,this.pid,this.cid,this.uid,this.initialflag}) : super(key: key);
  @override
  _CommentState createState() => _CommentState();
}

class _CommentState extends State<Comment> {
  bool _flagged=false;
  Color _splashcolor = Colors.red;
  Color _buttoncolor = Color(0xffFF4128);
  Color _iconcolor = Colors.grey;
  double _opacityNum = 1.0;
  bool _unflagged = false;
  Map alertBoxOptions = {
    'title': "Are you sure you want to flag this comment and report it?",
    'flag': "FLAG AND REPORT",
    'cancel': "CANCEL"
  };
  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            alertBoxOptions['title'],
            style: GoogleFonts.inter(
              letterSpacing: .25,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                    'One or two line from the comment taking up to 100 characters or keeping it at two lines followed by ...',
                    style: GoogleFonts.inter(
                        letterSpacing: .25,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Color.fromRGBO(0, 0, 0, 0.65))),
                SizedBox(
                  height: 31,
                ),
                FlatButton(
                  shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(6.0)),
                  color: _buttoncolor,
                  textColor: Colors.white,
                  disabledColor: Colors.grey,
                  disabledTextColor: Colors.black,
                  padding: EdgeInsets.symmetric(
                    vertical: 15,
                  ),
                  splashColor: _splashcolor,
                  onPressed: () {
                    if (_unflagged == false) {
                      Firestore.instance.collection("Post").document(widget.pid).collection("comments").document(widget.cid).updateData({
                        "FlaggedUid": FieldValue.arrayUnion([widget.uid]),
                      });
                      //flagging it
                      setState(() {
                        _iconcolor = Colors.orange;
                        _opacityNum = 0.3;
                        _flagged = true;
                      });
                    } else {
                      Firestore.instance.collection("Post").document(widget.pid).collection("comments").document(widget.cid).updateData({
                        "FlaggedUid": FieldValue.arrayRemove([widget.uid]),
                      });
                      setState(() {
                        _iconcolor = Colors.grey;
                        _opacityNum = 1.0;
                        _flagged = false;
                      });
                    }
                    Navigator.of(context, rootNavigator: true).pop();
                  },
                  child: Text(
                    alertBoxOptions['flag'],
                    style: GoogleFonts.inter(
                      letterSpacing: .25,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                FlatButton(
                  color: Colors.white,
                  textColor: Color(0xff718096),
                  disabledColor: Colors.grey,
                  disabledTextColor: Colors.black,
                  padding: EdgeInsets.symmetric(
                    vertical: 15,
                  ),
                  splashColor: Color(0xffb8b8b8),
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).pop();
                  },
                  child: Text(
                    alertBoxOptions['cancel'],
                    style: GoogleFonts.inter(
                      letterSpacing: .25,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    print(widget.initialflag);
    if(widget.initialflag==true){
      _flagged=true;
      _opacityNum=0.3;
      _iconcolor = Colors.orange;

    }
    return Opacity(
      opacity: _opacityNum,
      child: Container(
        margin: EdgeInsets.only(
          top: 8,
        ),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                CircleAvatar(
                  radius: 16,
                  backgroundImage: NetworkImage(
                      "https://www.woolha.com/media/2020/03/flutter-circleavatar-minradius-maxradius.jpg"),
                ),
                SizedBox(
                  width: 16,
                ),
                Text(widget.comment.name,
                    style: GoogleFonts.inter(
                      letterSpacing: .25,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    )),
                Spacer(),
                IconButton(
                    icon: Icon(EvaIcons.flagOutline, color: _iconcolor),
                    onPressed: () {
                      if (_flagged == false) {
                        alertBoxOptions['title'] =
                            "Are you sure you want to flag this comment and report it?";
                        alertBoxOptions['flag'] = "FLAG AND REPORT";
                        _buttoncolor = Color(0xffFF4128);
                        _splashcolor = Colors.red;
                        _showMyDialog();
                        _unflagged=false;
                      } else {
                        _unflagged = true;
                        alertBoxOptions['title'] =
                            "Are you sure you want to unflag this comment?";
                        alertBoxOptions['flag'] = "UNFLAG";
                        _buttoncolor = primarygreen;
                        _splashcolor = primarygreen;
                        _showMyDialog();
                      }
                    })
              ],
            ),
            SizedBox(
              height: 4,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 47, right: 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  widget.comment.commentdes,
                  style: GoogleFonts.inter(
                      letterSpacing: .25,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color.fromRGBO(0, 0, 0, 0.65)),
                ),
              ),
            ),
            SizedBox(height: 5,),
            Container(
              padding: EdgeInsets.only(left: 47),
              child: Align(
                alignment: Alignment.centerLeft,
                child: new Text(datetimeformat(widget.comment.date),
                    textAlign: TextAlign.left,
                    style: GoogleFonts.inter(
                        letterSpacing: 1,
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                        color: Color.fromRGBO(0, 0, 0, 0.65))),
              ),
            ),
            SizedBox(height: 10,),

            Divider()
          ],
        ),
      ),
    );
  }

  String datetimeformat(String date){
    String month = date.substring(5,7);
    int m =int.parse(month);
    switch (m) {
      case 1:
        month = "January";
        break;
      case 2:
        month = "February";
        break;
      case 3:
        month = "March";
        break;
      case 4:
        month = "April";
        break;
      case 5:
        month = "May";
        break;
      case 6:
        month = "June";
        break;
      case 7:
        month = "July";
        break;
      case 8:
        month = "August";
        break;
      case 9:
        month = "September";
        break;
      case 10:
        month = "October";
        break;
      case 11:
        month = "November";
        break;
      case 12:
        month = "December";
        break;
    }
    return date.substring(8,10) +"th "+month+" "+date.substring(0,4);
  }

}
