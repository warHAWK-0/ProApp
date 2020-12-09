import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:proapp/Models/Feed.dart';
import 'package:proapp/Screens/SignedIn/Feed/PostLayout/PollPost.dart';
import 'package:proapp/Screens/SignedIn/Feed/PostLayout/TextImagePost.dart';
import 'package:proapp/Screens/SignedIn/Feed/PostLayout/TextPost.dart';
import 'package:proapp/Widgets/CustomAppBar.dart';
import 'package:proapp/Widgets/themes.dart';

import 'PostLayout/PollPost.dart';
import 'PostLayout/PollPost.dart';
import 'PostLayout/TextImagePost.dart';

class FeedMain extends StatefulWidget {
  final String uid;

  const FeedMain({Key key, this.uid}) : super(key: key);
  @override
  _FeedMainState createState() => _FeedMainState();
}

class _FeedMainState extends State<FeedMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        child: Text(
          'Feed',
          style: Heading2(Colors.black,letterSpace: 1.25),
        ),
        elevation: true,
        backIcon: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Container(
            padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
            child: StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance.collection('Post').snapshots(),
              builder: (context,snapshot){
                if(!snapshot.hasData){
                  return SpinKitChasingDots(
                    color: Colors.black,
                    size: 30,
                  );
                }
                else{
                  return snapshot.data.documents.length==0? Text("no data"):
                   ListView.builder(
                     scrollDirection: Axis.vertical,
                       shrinkWrap: true,
                       itemCount: snapshot.data.documents.length,
                       itemBuilder: (context,index){
                          if(snapshot.data.documents[index]['Type']=="post"){
//                            return TextPost(
//                              description: snapshot.data.documents[index]['Description'],
//                              name: snapshot.data.documents[index]['Name'],
//                              datetime: snapshot.data.documents[index]['DateTime'],
//                              tag: snapshot.data.documents[index]['Tag'],
//                              upvote: snapshot.data.documents[index]['Upvote'],
//                              downvote: snapshot.data.documents[index]['Downvote'],
//                            );
                              return TextPost(
                                feed: FeedModel(
                                  uid: snapshot.data.documents[index]['uid'],
                                  name:snapshot.data.documents[index]['Name'],
                                  type:snapshot.data.documents[index]['Type'],
                                  datetime:snapshot.data.documents[index]['DateTime'],
                                  description:snapshot.data.documents[index]['Description'],
                                  downvote: snapshot.data.documents[index]['Downvote'],
                                  options:snapshot.data.documents[index]['options'],
                                  postid:snapshot.data.documents[index].documentID,
                                  tag:snapshot.data.documents[index]['Tag'],
                                  upvote:snapshot.data.documents[index]['Upvote'],
                                ),
                              );
                          }
                          else if(snapshot.data.documents[index]['Type']=="imagepost"){
                            return TextImagePost(
                              feed: FeedModel(
                                uid: snapshot.data.documents[index]['uid'],
                                name:snapshot.data.documents[index]['Name'],
                                type:snapshot.data.documents[index]['Type'],
                                datetime:snapshot.data.documents[index]['DateTime'],
                                description:snapshot.data.documents[index]['Description'],
                                downvote: snapshot.data.documents[index]['Downvote'],
                                options:snapshot.data.documents[index]['options'],
                                postid:snapshot.data.documents[index].documentID,
                                tag:snapshot.data.documents[index]['Tag'],
                                upvote:snapshot.data.documents[index]['Upvote'],
                              ),
                            );
                          }
                          else{return PollPost(
                            description: snapshot.data.documents[index]['Description'],
                            name: snapshot.data.documents[index]['Name'],
                            datetime: snapshot.data.documents[index]['DateTime'],
                            tag: snapshot.data.documents[index]['Tag'],
                            options: snapshot.data.documents[index]['Options'],

                          );}
                       }
                   );
                }
              },
            )
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
