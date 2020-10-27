import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:proapp/Widgets/themes.dart';

enum VoteType{
  feed,
  complaintCard
}


class VoteTemplate extends StatefulWidget {
  final VoteType type;
  final bool upvote;
  final bool downvote;
  final int upvoteCount;

  const VoteTemplate({
    @required this.type,
    this.upvote = false,
    this.downvote = false,
    @required this.upvoteCount
  });

  @override
  _VoteTemplateState createState() => _VoteTemplateState();
}

class _VoteTemplateState extends State<VoteTemplate> {
  @override
  Widget build(BuildContext context) {
    return widget.type == VoteType.feed ? Feed(
      upvote: widget.upvote,
      downvote: widget.downvote,
      upvoteCount: widget.upvoteCount,
    ) : Complaint(
      upvoteCount: widget.upvoteCount,
      upvote: widget.upvote,
    );
  }
}

class Feed extends StatefulWidget {
  bool upvote;
  bool downvote;
  int upvoteCount;

  Feed({
    this.upvote = false,
    this.downvote = false,
    @required this.upvoteCount
  });


  @override
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  void _onClickUpvote(){
    setState(() {
      widget.upvoteCount = widget.upvote ? widget.upvoteCount-1 : widget.upvoteCount+1;
      widget.upvote = !widget.upvote;
      widget.downvote = false;
    });
  }

  void _onClickDownvote(){
    setState(() {
      widget.upvoteCount = widget.upvote ? widget.upvoteCount-1 : widget.upvoteCount;
      widget.downvote = !widget.downvote;
      widget.upvote = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 26,
      width: 104,
      padding: EdgeInsets.symmetric(horizontal: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            onTap: _onClickUpvote,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(2.0)),
                color: widget.upvote ? primarygreen : Colors.white,
              ),
              child: Column(
                children: [
                  Icon(Icons.keyboard_arrow_up, color: widget.upvote ? Colors.white : Colors.black,),
                  Spacer(),
                ],
              ),
            ),
          ),
          Spacer(),
          Text(
            widget.upvoteCount.toString(),
            style: TextStyle(
              fontSize: 14,
              letterSpacing: 1.25,
              color: Colors.black,
            ),
          ),
          Spacer(),
          InkWell(
            onTap: _onClickDownvote,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(2.0)),
                color: widget.downvote? Colors.red : Colors.white,
              ),
              child: Column(
                children: [
                  Icon(Icons.keyboard_arrow_down, color: widget.downvote ? Colors.white : Colors.black,),
                  Spacer(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Complaint extends StatefulWidget {
  bool upvote;
  int upvoteCount;

  Complaint({
    this.upvote = false,
    @required this.upvoteCount
  });
  @override
  _ComplaintState createState() => _ComplaintState();
}

class _ComplaintState extends State<Complaint> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        setState(() {
          widget.upvoteCount = widget.upvote ? widget.upvoteCount-1 : widget.upvoteCount+1;
          widget.upvote = !widget.upvote;
        });
      },
      child: Container(
        width: 74,
        height: 26,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(3.0)),
          color: widget.upvote ? primarygreen : Colors.blueGrey[50],
        ),
        padding: EdgeInsets.symmetric(horizontal: 6.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              widget.upvoteCount.toString(),
              style: TextStyle(
                fontSize: 14,
                letterSpacing: 1.25,
                color: widget.upvote ? Colors.white : Colors.black,
              ),
            ),
            Spacer(),
            Container(
              child: Column(
                children: [
                  Icon(Icons.keyboard_arrow_up, color: widget.upvote ? Colors.white : Colors.black,),
                  Spacer()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}


