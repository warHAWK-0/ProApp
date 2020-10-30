import 'package:flutter/material.dart';
import 'package:proapp/Screens/SignedIn/Feed/PostLayout/PollPost.dart';
import 'package:proapp/Screens/SignedIn/Feed/PostLayout/TextImagePost.dart';
import 'package:proapp/Screens/SignedIn/Feed/PostLayout/TextPost.dart';
import 'package:proapp/Widgets/CustomAppBar.dart';
import 'package:proapp/Widgets/themes.dart';

class FeedMain extends StatefulWidget {
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
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
          child: Column(
            children: [
              // ListView.builder(
              //     padding: EdgeInsets.only(bottom: 8),
              //     itemCount: 1,
              //     itemBuilder: (BuildContext context, int index) {
              //       return TextImagePost();
              //     }
              // ),
              // ListView.builder(
              //     padding: EdgeInsets.only(bottom: 8),
              //     itemCount: 1,
              //     itemBuilder: (BuildContext context, int index) {
              //       return PollPost();
              //     }
              // ),
              PollPost(),
              TextImagePost(),
              TextPost(),
            ],
          ),
        ),
      ),
    );
  }
}
