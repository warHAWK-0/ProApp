import 'package:flutter/material.dart';
import 'package:proapp/Screens/SignedIn/Feed/PostLayout/TextImagePost.dart';
import 'package:proapp/Widgets/CustomAppBar.dart';

class FeedMain extends StatefulWidget {
  @override
  _FeedMainState createState() => _FeedMainState();
}

class _FeedMainState extends State<FeedMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        child: Text(
          'Feed',
          //style: ,
        ),
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
        child: ListView.builder(
            padding: EdgeInsets.only(bottom: 8),
            itemCount: 1,
            itemBuilder: (BuildContext context, int index) {
              return TextImagePost();
            }
        ),
      ),
    );
  }
}
