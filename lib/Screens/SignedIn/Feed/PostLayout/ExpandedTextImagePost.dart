import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fleva_icons/fleva_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proapp/Models/Comment.dart';
import 'package:proapp/Models/Feed.dart';
import 'package:proapp/Screens/SignedIn/Feed/PostLayout/comment.dart';
import 'package:proapp/Services/database.dart';
import 'package:proapp/Widgets/VoteTemplate.dart';
import 'package:footer/footer.dart';
import 'package:footer/footer_view.dart';
import 'package:proapp/Widgets/commentgrab.dart';
import 'package:proapp/Widgets/themes.dart';


class PostdetailsImage extends StatefulWidget {
  final FeedModel feed;
  final String url,uid;

  const PostdetailsImage({Key key, this.feed,this.url,this.uid}) : super(key: key);


  @override
  _PostdetailsImageState createState() => _PostdetailsImageState();
}

class _PostdetailsImageState extends State<PostdetailsImage> {
  DatabaseService _initiateDBService() => new DatabaseService();
  bool isPressed = false;
  bool isPressed1 = false;
  TextEditingController _commentController =TextEditingController();
  _showPostPicture() {
    return FutureBuilder(
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return Container(
            child: SpinKitChasingDots(
              color: Colors.black,
              size: 24,
            ),
          );
        else {
          return  ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                widget.url,
                fit: BoxFit.fill,
              )
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    DatabaseService db = _initiateDBService();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        //title: Center(child: Text("Feed",style: TextStyle(color: Colors.black,),)),
        backgroundColor: Colors.white,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back_ios),
          color: Color(0xff20BAA2),
          onPressed: () {
            Navigator.pop(context);
            
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            //SingleChildScrollView(

              Container(
                margin: EdgeInsets.only(top: 15, bottom: 15),
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Row(
                      children: <Widget>[
                        CircleAvatar(
                          radius: 16,
                          backgroundImage: NetworkImage(
                              "https://www.woolha.com/media/2020/03/flutter-circleavatar-minradius-maxradius.jpg"),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        new Text(widget.feed.name,
                            style: GoogleFonts.inter(
                              letterSpacing: .25,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            )),
                        Spacer(),
                        new Container(
                          height: 25,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(13),
                            color: Color(0xFF189F98),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(left: 10, right :10),
                            child: Center(
                              child: Text(widget.feed.tag.toUpperCase(), style:GoogleFonts.inter( letterSpacing: 1.5,fontSize: 10,
                                  fontWeight: FontWeight.w500, color: Colors.white) ),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    _showPostPicture(),
                    SizedBox(
                      height: 10,
                    ),
                    VoteTemplate(type: VoteType.feed, upvoteCount: widget.feed.upvote, downvoteCount: widget.feed.downvote,),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                          widget.feed.description+'\n',style: GoogleFonts.inter(
                          letterSpacing: .25,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color.fromRGBO(0, 0, 0, 0.65)),

                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: new Text(datetimeformat(widget.feed.datetime),
                          textAlign: TextAlign.left,
                          style: GoogleFonts.inter(
                              letterSpacing: 1,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Color.fromRGBO(0, 0, 0, 0.65))),
                    ),
                    Divider(
                      height: 35,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        child: Text("Comments",style: GoogleFonts.inter(
                          letterSpacing: 1,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,)),
                      ),
                    ),
                    CommentGrab(pid: widget.feed.postid,uid: widget.uid,),

                  ],

                ),

              ),

          //  ),
          ],
        ),
      ),
        bottomNavigationBar: Padding(padding: MediaQuery.of(context).viewInsets,

          child:Container(
            decoration: BoxDecoration(
                border: Border.all(color: Color(0xffdcdcdc))
            ),
            padding: EdgeInsets.only(bottom: 8,left: 16,right: 16),
            child: TextFormField(

              //keyboardType: TextInputType.multiline,
             maxLines: 1,
              controller: _commentController,
              cursorColor:primarygreen,
              decoration: InputDecoration(
                icon:CircleAvatar(
                  radius: 16,
                  backgroundImage: NetworkImage(
                      "https://www.woolha.com/media/2020/03/flutter-circleavatar-minradius-maxradius.jpg"),
                ),
                labelStyle: TextStyle(
                  color: primarygreen,
                ),
//                  suffixIcon: hastext==false?IconButton(
//                    icon:Icon(FlevaIcons.paper_plane,color: Colors.grey),
//                    onPressed: (){
//
//                    },
//                  ):
                suffixIcon:IconButton(
                  icon:Icon(FlevaIcons.paper_plane,color: primarygreen),
                  onPressed: ()async{
                    if (_commentController.text!=""){ //creating a new document for comment
                    CommentModel _comment =new CommentModel(
                      commentdes: _commentController.text,
                      name: "Pikachu",
                      date: DateTime.now().toString().substring(0,16),
                      flaggedUid: [],
                    );
                    this.setState(() {
                      _commentController.clear();
                    });
                    await db.post.document(widget.feed.postid).collection("comments").document().setData(_comment.toJson());
                       }

                  },
                )
                ,
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xffdcdcdc)),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: primarygreen),
                ),
                hintText: "Type here",
              ),
//                validator: (value){
//                  if (value.isNotEmpty){
//                    print(_commentController.toString());
//                    print("insde");
//                    setState(() {
//                      print("setttttt");
//                      hastext=true;
//                    });
//
//                  }
//
//                  return null;
//                },
            ),
          ),

        )


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
