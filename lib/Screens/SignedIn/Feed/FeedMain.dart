import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:proapp/Models/Feed.dart';
import 'package:proapp/Screens/SignedIn/Feed/PostLayout/PollPost.dart';
import 'package:proapp/Screens/SignedIn/Feed/PostLayout/TextImagePost.dart';
import 'package:proapp/Screens/SignedIn/Feed/PostLayout/TextPost.dart';
import 'package:proapp/Services/database.dart';
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

  ScrollController _scrollController = ScrollController();
  List<DocumentSnapshot> posts = [];
  bool hasMore =false;
  bool loading =false;
  DocumentSnapshot lastdocument;
  int doclimit=10;

  getfeed() async{
    if(!hasMore){
      return;
    }
    if(loading){
      return;
    }
    setState(() {
      loading=true;
    });
    QuerySnapshot querySnapshot;
    if(lastdocument==null){
      querySnapshot = await DatabaseService.firestore.collection('Post').limit(doclimit).getDocuments();
    }else{
      querySnapshot =await DatabaseService.firestore.collection('Post').limit(doclimit).getDocuments();
    }
    if(querySnapshot.documents.length < doclimit){
      hasMore =false;
    }
    lastdocument =querySnapshot.documents[querySnapshot.documents.length -1];
    posts.addAll(querySnapshot.documents);
    setState(() {
      loading=false;
    });
  }


  @override
  Widget build(BuildContext context) {

    _scrollController.addListener(() {
      double maxScroll = _scrollController.position.maxScrollExtent;
      double currentScroll = _scrollController.position.pixels;
      double delta =MediaQuery.of(context).size.height *0.2;
      if(maxScroll-currentScroll<=delta){
        getfeed();
      }
    });

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
                                  options:snapshot.data.documents[index]['Options'],
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
                                options:snapshot.data.documents[index]['Options'],
                                postid:snapshot.data.documents[index].documentID,
                                tag:snapshot.data.documents[index]['Tag'],
                                upvote:snapshot.data.documents[index]['Upvote'],
                              ),
                              uid: widget.uid,
                            );
                          }
                          else{
                            bool checkvoted=false;
                            DateTime temp=DateTime.parse(snapshot.data.documents[index]['DateTime']);
                            //41:41:40.778347
                            if(DateTime.now().difference(temp)>Duration(days: 1)){    //checks if the posst is more than a day old
                            checkvoted=true;
                            }
                            print(DateTime.now().difference(temp));
                            for (int i =0;i<snapshot.data.documents[index]['Options'].values.toList().length;i++){ //checks if the user has voted or not
                              if (snapshot.data.documents[index]['Options'].values.toList()[i].contains(widget.uid)){
                                checkvoted=true;
                              }
                            }

                            return PollPost(
                              myuid: widget.uid,
                              feed: FeedModel(
                              uid: snapshot.data.documents[index]['uid'],
                              name:snapshot.data.documents[index]['Name'],
                                type:snapshot.data.documents[index]['Type'],
                                datetime:snapshot.data.documents[index]['DateTime'],
                              description:snapshot.data.documents[index]['Description'],
                              downvote: snapshot.data.documents[index]['Downvote'],
                              options:snapshot.data.documents[index]['Options'],
                              postid:snapshot.data.documents[index].documentID,
                              tag:snapshot.data.documents[index]['Tag'],
                              upvote:snapshot.data.documents[index]['Upvote'],

                          ),
                            checker: checkvoted,);
                          }
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
