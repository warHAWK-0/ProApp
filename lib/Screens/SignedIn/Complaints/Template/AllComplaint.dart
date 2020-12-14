import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:proapp/Models/Complaint.dart';
import 'package:proapp/Models/Filter.dart';
import 'package:proapp/Services/authentication.dart';
import 'package:proapp/Services/database.dart';
import 'package:proapp/Widgets/themes.dart';

import 'ComplaintCard.dart';

class AllComplaint extends StatefulWidget {
  final String uid;
  Filter filter;
  AllComplaint({
    this.uid,
    this.filter
  });

  @override
  _AllComplaintState createState() => _AllComplaintState();
}

class _AllComplaintState extends State<AllComplaint> {
  DatabaseService db;
  Auth auth = new AuthService();
  ScrollController _scrollController = ScrollController();
  List<DocumentSnapshot> complaints = [];
  bool hasMore = false;
  bool loading = false;
  DocumentSnapshot lastdocument;
  int doclimit = 10;
  List<String> pincode;
  String pinValue = "562107";

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
      querySnapshot = await db.myComplaint()
          .limit(doclimit)
          .getDocuments();
    } else {
      querySnapshot = await db.myComplaint()
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
    return Container(
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

  Future _getPin() async{
    var pinDoc =
        await Firestore.instance.collection("Utils").document("Pincode").get();
    pincode = pinDoc.data['Pincode'].cast<String>();
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

    return FutureBuilder(
      future: _getPin(),
      builder:(context,snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting){
          return _showFetchComplaintContainer();
        }
        else
          return StreamBuilder<QuerySnapshot>(
            stream: db.allComplaint(pinValue).snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return _showFetchComplaintContainer();
              } else {
                return Column(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 16),
                      padding: EdgeInsets.symmetric(horizontal: 8,vertical: 4),
                      color: Colors.grey[100],
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text('Change your region : '),
                            DropdownButton<String>(
                              value: pinValue,
                              elevation: 0,
                              underline: Container(height: 2,color: Colors.black,),
                              onChanged: (String newValue) {
                                setState(() {
                                  pinValue = newValue;
                                });
                              },
                                items: pincode
                                    .map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList()
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                    snapshot.data.documents.length == 0
                        ? _noCompalaintFoundContainer()
                        : ListView.builder(
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
                        }),
                  ],
                );
              }
            },
          );
      }
    );
  }
}
