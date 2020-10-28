import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/painting.dart';
import 'package:google_fonts/google_fonts.dart';
import 'ExpandedTextImagePost.dart';
//import 'file:///E:/Flutter/proapp/lib/Screens/SignedIn/Feed/PostLayout/readmore.dart';
import 'readmore.dart';

class TextImagePost extends StatefulWidget {
  @override
  _TextPostState createState() => _TextPostState();
}

class _TextPostState extends State<TextImagePost> {
  bool isPressed = false;
  bool isPressed1 = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: <Widget>[
          new Row(
            children: <Widget>[
              CircleAvatar(radius: 16,backgroundImage: NetworkImage("https://www.woolha.com/media/2020/03/flutter-circleavatar-minradius-maxradius.jpg") ,),
              SizedBox(width: 10,),
              new Text("Anonymous Name", style: GoogleFonts.inter( letterSpacing: .25,fontSize: 16,
                fontWeight: FontWeight.w400,)),

              Spacer(),
              new Container(
                height: 25,
                width: 45,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(13),
                  color: Color(0xFF189F98),
                ),

                child: Center(
                  child: Text("TAGS", style:GoogleFonts.inter( letterSpacing: 1.5,fontSize: 10,
                      fontWeight: FontWeight.w500, color: Colors.white) ),
                ),
              )


            ],
          ),
          SizedBox(height: 10,),
          ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network("https://t8x8a5p2.stackpathcdn.com/wp-content/uploads/2018/05/Birthday-Cake-Recipe-Image-720x720.jpg")
          ),
          SizedBox(height: 10,),
          Row(
            children: <Widget>[
              // Toggle the up, down button and fill the box
              IconButton(icon: Icon(EvaIcons.arrowIosUpwardOutline),
                color: (isPressed)? Colors.green: Colors.grey,
                onPressed: (){
                  setState(() {
                    isPressed=true;
                  });
                },),
              Text("9999", style: GoogleFonts.inter(letterSpacing: 1, fontSize: 14,fontWeight: FontWeight.w600, color: Color.fromRGBO(0,0,0,0.65))),
              IconButton(icon: Icon(EvaIcons.arrowIosDownwardOutline),
                color: (isPressed1)? Colors.red: Colors.grey,
                onPressed: (){
                  setState(() {
                    isPressed1=true;
                  });
                },),
              Spacer(),
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Postdetails()));
                },
                  child: Text("View Comments", style: GoogleFonts.inter(letterSpacing: .5, fontSize: 12,fontWeight: FontWeight.w600, color: Color(0XFF20BAA2)))),

            ],
          ),
          ReadMoreText(
            'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using Content here, content here, making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for  will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).',
            style: GoogleFonts.inter(letterSpacing: .25, fontSize: 14, fontWeight: FontWeight.w400, color: Color.fromRGBO(0, 0, 0, 0.65)),
            trimLines: 3,
            colorClickableText: Color(0xFF20BAA2),
            trimMode: TrimMode.Line,
            trimCollapsedText: 'Read More',
            trimExpandedText: 'Read less',
          ),
          SizedBox(height: 10,),
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
          Divider(height: 35,)
        ],
      ),
    );
  }
}

//void doSomething(String buttonName){
//  if(buttonName)
//}