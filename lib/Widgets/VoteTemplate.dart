import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:proapp/Models/Complaint.dart';
import 'package:proapp/Services/database.dart';
import 'package:proapp/Widgets/themes.dart';

enum VoteType{
  feed,
  complaintCard
}


class VoteTemplate extends StatefulWidget {
  final compaintId;
  final String uid;
  final VoteType type;
  final bool upvote;
  final bool downvote;
  final int upvoteCount;
  final int downvoteCount;
  Complaint complaint;

  VoteTemplate({
    @required this.type,
    this.upvote = false,
    this.complaint,
    this.downvote = false,
    @required this.upvoteCount,
    this.downvoteCount = 0,
    this.uid, this.compaintId,
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
      downvoteCount: widget.downvoteCount,
    ) : ComplaintVote(
      complaintId: widget.compaintId,
      uid: widget.uid,
      upvoteCount: widget.upvoteCount,
      upvote: widget.upvote,
      complaint: widget.complaint,
    );
  }
}

class Feed extends StatefulWidget {
  bool upvote;
  bool downvote;
  int upvoteCount;
  int downvoteCount;

  Feed({
    this.upvote = false,
    this.downvote = false,
    @required this.upvoteCount,
    @required this.downvoteCount,
  });


  @override
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  void _onClickUpvote(){
    setState(() {
      if(widget.upvote == false && widget.downvote == false)
        widget.upvoteCount += 1;
      else if(widget.upvote == true && widget.downvote == false){
        widget.upvoteCount -= 1;
      }
      else{
        widget.upvoteCount += 1;
        widget.downvoteCount -= 1;
      }
      widget.upvote = !widget.upvote;
      widget.downvote = false;
    });
  }

  void _onClickDownvote(){
    setState(() {
      if(widget.upvote == false && widget.downvote == false)
        widget.downvoteCount += 1;
      else if(widget.upvote == false && widget.downvote == true){
        widget.downvoteCount -= 1;
      }
      else{
        widget.downvoteCount += 1;
        widget.upvoteCount -= 1;
      }
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
            (widget.upvoteCount+widget.downvoteCount).toString(),
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

class ComplaintVote extends StatefulWidget {
  final String complaintId;
  final String uid;
  bool upvote;
  int upvoteCount;
  final Complaint complaint;

  ComplaintVote({
    this.upvote = false,
    @required this.upvoteCount,
    this.uid,
    this.complaintId, this.complaint,
  });
  @override
  _ComplaintVoteState createState() => _ComplaintVoteState();
}

class _ComplaintVoteState extends State<ComplaintVote> {
  Future<void> updateVoteCount(int upvoteCount) async {
    DatabaseService db = DatabaseService(uid: widget.uid);
    // updating value in complaint document
    db.myComplaint(currUid: widget.complaint.uid).document(widget.complaintId)
        .updateData({
      'Upvote': upvoteCount,
    });

    // update all complaint
    String pincode = widget.complaint.location.substring(widget.complaint.location.length - 6);
    db.allComplaint(pincode).document(widget.complaintId)
        .updateData({
      'Upvote': upvoteCount,
    });

    // update assigned (if any)
    if(widget.complaint.assigned != null)
      db.assignedComplaint(currUid: widget.complaint.assigned['By']).document(widget.complaintId)
          .updateData({
        'Upvote': upvoteCount,
      });
  }

  Future<void> updateListOfLikedComplaints() async{
    DatabaseService db = DatabaseService(uid: widget.uid);
    if(temp){
      // update likedComplaint field
      await db.myComplaint(currUid: widget.complaint.uid).document(widget.complaintId).updateData({
        'LikedByUsers': FieldValue.arrayRemove([widget.uid]),
      });

      // update all complaint documnet
      String pincode = widget.complaint.location.substring(widget.complaint.location.length - 6);
      db.allComplaint(pincode).document(widget.complaintId).updateData({
        'LikedByUsers': FieldValue.arrayRemove([widget.uid]),
      });

      // update assigned complaint
      if(widget.complaint.assigned != null)
      db.assignedComplaint(currUid: widget.complaint.assigned['By']).document(widget.complaintId).updateData({
        'LikedByUsers': FieldValue.arrayRemove([widget.uid]),
      });
    }
    else{
      // update likedComplaint field
      await db.myComplaint(currUid: widget.complaint.uid).document(widget.complaintId).updateData({
        'LikedByUsers': FieldValue.arrayUnion([widget.uid]),
      });

      // all complaint
      String pincode = widget.complaint.location.substring(widget.complaint.location.length - 6);
      db.allComplaint(pincode).document(widget.complaintId).updateData({
        'LikedByUsers': FieldValue.arrayUnion([widget.uid]),
      });

      // assigned
      if(widget.complaint.assigned != null)
        db.assignedComplaint(currUid: widget.complaint.assigned['By']).document(widget.complaintId).updateData({
        'LikedByUsers': FieldValue.arrayUnion([widget.uid]),
      });
    }
  }

  //temporary variable that stores previous state of widget.upvote(boolean value)
  bool temp;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async{
        setState(() {
          widget.upvoteCount = widget.upvote ? widget.upvoteCount-1 : widget.upvoteCount+1;
          temp = widget.upvote;
          widget.upvote = !widget.upvote;
        });
        updateVoteCount(widget.upvoteCount);
        updateListOfLikedComplaints();
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
            Spacer(),
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


