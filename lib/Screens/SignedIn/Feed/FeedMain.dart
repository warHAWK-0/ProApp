import 'package:flutter/material.dart';
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
      appBar: CustomAppBar(
        child: Text(
          'Feed',
          style: Heading2(Colors.black,letterSpace: 1.25),
        ),
        elevation: true,
        backIcon: false,
      ),
      body: Container(
        padding: EdgeInsets.only(top: 5),
        child: ListView.builder(
            padding: EdgeInsets.only(bottom: 8),
            itemCount: 5,
            itemBuilder: (BuildContext context, int index) {
              return TextImagePost();
            }
        ),
      ),
    );
  }
}
