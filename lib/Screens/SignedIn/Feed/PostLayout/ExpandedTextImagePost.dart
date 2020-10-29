import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proapp/Screens/SignedIn/Feed/PostLayout/comment.dart';
import 'package:proapp/Widgets/VoteTemplate.dart';

class Postdetails extends StatefulWidget {
  @override
  _PostdetailsState createState() => _PostdetailsState();
}

class _PostdetailsState extends State<Postdetails> {
  bool isPressed = false;
  bool isPressed1 = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        child: Container(
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
                  new Text("Anonymous Name",
                      style: GoogleFonts.inter(
                        letterSpacing: .25,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      )),
                 Spacer(),
                  new Container(
                    height: 25,
                    width: 45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(13),
                      color: Color(0xFF189F98),
                    ),
                    child: Center(
                      child: Text("TAGS",
                          style: GoogleFonts.inter(
                              letterSpacing: 1.5,
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              color: Colors.white)),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.network(
                      "https://t8x8a5p2.stackpathcdn.com/wp-content/uploads/2018/05/Birthday-Cake-Recipe-Image-720x720.jpg")),
              SizedBox(
                height: 10,
              ),
              VoteTemplate(type: VoteType.feed, upvoteCount: 234),
              SizedBox(
                height: 10,
              ),
              Text(
                'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using Content here, content here, making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for  will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).',
                style: GoogleFonts.inter(
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
                child: new Text("28th September 2020",
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
              ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  //padding: const EdgeInsets.all(8),
                  itemCount: 5,
                  itemBuilder: (BuildContext context, int index) {
                    return Comment();
                  }
              ),
            ],
          ),
        ),
      ),
    );
  }
}
