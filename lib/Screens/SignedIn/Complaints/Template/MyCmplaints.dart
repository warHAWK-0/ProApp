import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:proapp/Models/Complaint.dart';
import 'package:proapp/Screens/SignedIn/Complaints/Template/ComplaintCard.dart';
import 'package:proapp/Services/authentication.dart';
import 'package:proapp/Services/database.dart';
import 'package:proapp/Widgets/themes.dart';

import '../../../../Widgets/themes.dart';

class MyComplaint extends StatefulWidget {
  final String uid;

  const MyComplaint({Key key, this.uid}) : super(key: key);
  @override
  _MyComplaintState createState() => _MyComplaintState();
}

class _MyComplaintState extends State<MyComplaint> {
  DatabaseService db;
  Auth auth = new AuthService();
  ScrollController _scrollController = ScrollController();
  List<DocumentSnapshot> complaints = [];
  bool hasMore = false;
  bool loading = false;
  DocumentSnapshot lastdocument;
  int doclimit = 10;

  getcomplaints() async {
    if (!hasMore) {
      return;
    }
    if (loading) {
      return;
    }
    setState(() {
      loading = true;
    });
    QuerySnapshot querySnapshot;
    if (lastdocument == null) {
      querySnapshot = await DatabaseService.firestore
          .collection('comaplaint')
          .limit(doclimit)
          .getDocuments();
    } else {
      querySnapshot = await DatabaseService.firestore
          .collection('comaplint')
          .limit(doclimit)
          .getDocuments();
    }
    if (querySnapshot.documents.length < doclimit) {
      hasMore = false;
    }
    lastdocument = querySnapshot.documents[querySnapshot.documents.length - 1];
    complaints.addAll(querySnapshot.documents);
    setState(() {
      loading = false;
    });
  }

  _showFetchComplaintContainer() {
    Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Spacer(),
          SpinKitCubeGrid(
            color: primarygreen,
          ),
          SizedBox(
            height: 4,
          ),
          Text(
            'Fetching your complaints...',
            style: Heading4(Colors.grey[400]),
          ),
          Spacer(),
        ],
      ),
    );
  }

  Widget _noCompalaintFoundContainer() {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 7,
            ),
            Container(
              height: MediaQuery.of(context).size.width / 1.17,
              width: MediaQuery.of(context).size.width / 1.17,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image:
                          AssetImage('Assets/img/no_complaint_found_all.png'),
                      fit: BoxFit.fill)),
            )
          ],
        ),
      ),
    );
  }

  var likedComplaint;
  Future _getLikedComplaintList() async {
    print('here');
    likedComplaint = await db.getlikedcomplaints();
  }

  @override
  Widget build(BuildContext context) {
    _scrollController.addListener(() {
      double maxScroll = _scrollController.position.maxScrollExtent;
      double currentScroll = _scrollController.position.pixels;
      double delta = MediaQuery.of(context).size.height * 0.2;
      if (maxScroll - currentScroll <= delta) {
        getcomplaints();
      }
    });

    db = new DatabaseService(uid: widget.uid);
    return Container(
      child: StreamBuilder<QuerySnapshot>(
        stream: db.complaint
            .document(widget.uid)
            .collection(widget.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return _showFetchComplaintContainer();
          } else {
            return snapshot.data.documents.length == 0
                ? _noCompalaintFoundContainer()
                :
                // map complaints to complaint card
                ListView.builder(
                    controller: _scrollController,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (context, index) {
                      return ComplaintCard(
                        complaint: Complaint(
                          complaintType: snapshot.data.documents[index]
                              ['ComplaintType'],
                          complaintId:
                              snapshot.data.documents[index].documentID,
                          departmentName: snapshot.data.documents[index]
                              ['DepartmentName'],
                          description: snapshot.data.documents[index]
                              ['Description'],
                          status: snapshot.data.documents[index]['Status'],
                          uid: snapshot.data.documents[index]['UID'],
                          location: snapshot.data.documents[index]['Location'],
                          start: snapshot.data.documents[index]['Start'],
                          end: snapshot.data.documents[index]['End'],
                          verification: snapshot.data.documents[index]
                              ['Verification'],
                          assigned: snapshot.data.documents[index]['Assigned'],
                          upvote: snapshot.data.documents[index]['Upvote'],
                          likedByUsers: snapshot.data.documents[index]
                              ['LikedByUsers'],
                        ),
                        uid: widget.uid,
                      );
                    });
          }
        },
      ),
    );
  }
}
