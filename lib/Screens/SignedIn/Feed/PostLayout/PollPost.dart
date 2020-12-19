import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/painting.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:proapp/Models/Feed.dart';
import 'package:proapp/Widgets/VoteTemplate.dart';
import 'package:proapp/Widgets/themes.dart';
import 'package:recase/recase.dart';
import 'readmore.dart';

class PollPost extends StatefulWidget {
  final FeedModel feed;
  final bool checker;
  final String myuid;
  const PollPost({Key key, this.feed,this.checker,this.myuid }) : super(key: key);
  @override
  _PollPostState createState() => _PollPostState();
}

class _PollPostState extends State<PollPost> {
  bool isPressed = false;
  bool isPressed1 = false;
  bool showpolls=false;
  var percent ;
  void calculatePercent(){
    percent = new List(widget.feed.options.values.toList().length);
    int sum=0;
    for (int i =0;i<widget.feed.options.values.toList().length;i++){
      sum+=widget.feed.options.values.toList()[i].length;
    }
    for (int i =0;i<widget.feed.options.values.toList().length;i++){
      if(widget.feed.options.values.toList()[i].isEmpty) {percent[i]=0.00001;}
      else{
        percent[i]=widget.feed.options.values.toList()[i].length/sum;
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
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
          Align(
            alignment: Alignment.centerLeft,
            child: ReadMoreText(
              widget.feed.description+"\n",
              style: GoogleFonts.inter(
                  letterSpacing: .25,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color.fromRGBO(0, 0, 0, 0.65)),
              trimLines: 3,
              colorClickableText: Color(0xFF20BAA2),
              trimMode: TrimMode.Line,
              trimCollapsedText: '....\nRead More',
              trimExpandedText: 'Read less',
            ),
          ),
          SizedBox(
            height: 10,
          ),
          (showpolls||widget.checker)?  ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: widget.feed.options.length,
              itemBuilder: (BuildContext context, index){
                calculatePercent();
                return Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey[300],
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(32.0),
                      ),
                      //padding: EdgeInsets.only(bottom: 8),
                      child: LinearPercentIndicator(
                        backgroundColor: Colors.white,
                        width: MediaQuery.of(context).size.width-64,
                        animation: true,
                        animationDuration: 1000,
                        lineHeight: 46.0,
                        percent: percent[index],
                        center: Row(
                          children: [
                            Text(widget.feed.options.keys.elementAt(index).toString(),style: TextStyle(color: Color.fromRGBO(0, 0, 0, 0.65)),),
                            Spacer(),
                            Text((percent[index]*100).toString().substring(0,4)+"%"),
                          ],
                        ),
                        linearStrokeCap: LinearStrokeCap.roundAll,
                        progressColor: primarygreen,
                      ),

                    ),
                    SizedBox(
                      height: 8,
                    )
                  ],
                );
              })
              :ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: widget.feed.options.length,
              itemBuilder: (BuildContext context, index){
                return SizedBox(
                  width: double.infinity,
                  child: OutlineButton(
                    child: Text(
                      widget.feed.options.keys.elementAt(index).toString().pascalCase,
                      style: TextStyle(color: Color(0xff20BAA2)),
                    ),
                    onPressed: ()async{

                      await Firestore.instance.collection('Post').document(widget.feed.postid).updateData({

                        "Options."+widget.feed.options.keys.elementAt(index).toString(): FieldValue.arrayUnion([widget.myuid]),
                      });
                      setState(() {
                        showpolls=true;
                      });
                      calculatePercent();

                      //print(widget.feed.options.values.elementAt(index));
                    },
                  ),
                );
              }
          ),
          SizedBox(height: 10,),
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
          )
        ],
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
