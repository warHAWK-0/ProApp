import 'package:fleva_icons/fleva_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proapp/Widgets/CustomAppBar.dart';
import 'package:proapp/Widgets/Tag.dart';
import 'package:proapp/Widgets/themes.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';

class FilterAllComplaint extends StatefulWidget {
  @override
  _FilterAllComplaintState createState() => _FilterAllComplaintState();
}

class _FilterAllComplaintState extends State<FilterAllComplaint> {
  DateTime fromDate = DateTime.now();
  DateTime toDate = DateTime.now();
  Color wProgress = Colors.black;
  Color wRaised = Colors.black;
  Color wCompleted = Colors.black;
  Color cRaised = Color(0xffF7FAFC);
  Color cProgress = Color(0xffF7FAFC);
  Color cCompleted = Color(0xffF7FAFC);
  Color cRecent = Color(0xffF7FAFC);
  Color cPopular = Color(0xffF7FAFC);
  Color _dateColor = Color.fromRGBO(0, 0, 0, 0.45);
  final List<String> _department = [
    'Department 1',
    'Department 2',
    'Department 3'
  ];
  final List<String> _complaint = [
    'Complaint 101',
    'Complaint 012',
    'Complaint 201'
  ];
  Map<String, String> selectedValueMap = Map();

  List _onTapColorStatus(Color currentColor, Color selectedColor) {
    if (currentColor != selectedColor) {
      return [selectedColor, Colors.white];
    } else {
      return [Color(0xffF7FAFC), Colors.black];
    }
  }

  List _onTapColorSort(Color current, Color other) {
    if (current == Color(0xffF7FAFC)) {
      if (other == Color(0xffFCBD5E0)) {
        return [Color(0xffFCBD5E0), Color(0xffF7FAFC)];
      } else {
        return [Color(0xffFCBD5E0), Color(0xffF7FAFC)];
      }
    } else {
      return [Color(0xffF7FAFC), Color(0xffF7FAFC)];
    }
  }

  @override
  void initState() {
    selectedValueMap["department"] = null;
    selectedValueMap["complaint"] = null;
    super.initState();
  }

  Widget getSearchableDropdown(List<String> listData, mapKey) {
    List<DropdownMenuItem> items = [];
    for (int i = 0; i < listData.length; i++) {
      items.add(DropdownMenuItem(
        child: Text(
          listData[i],
        ),
        value: listData[i],
      ));
    }
    return SearchableDropdown(
      items: items,
      value: selectedValueMap[mapKey],
      isExpanded: true,
      isCaseSensitiveSearch: false,
      closeButton: 'Close',
      hint: Text(
        'Select ' + mapKey,
      ),
      searchHint: Text(
        'Select ' + mapKey,
        style: TextStyle(fontSize: 20),
      ),
      onChanged: (value) {
        setState(() {
          selectedValueMap[mapKey] = value;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        child: Text(
          'Filters',
          style: Heading2(Colors.black, letterSpace: 1.0),
        ),
        elevation: true,
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            getSearchableDropdown(_complaint, "complaint"),
            Divider(
              thickness: 1,
              height: 24,
            ),
            Text(
              "Department",
              //style: complaintCardHeading,
            ),
            SizedBox(
              height: 8,
            ),
            getSearchableDropdown(_department, "department"),
            SizedBox(height: 24),
            Text(
              "Type of Complaint",
              //style: complaintCardHeading,
            ),
            SizedBox(
              height: 8,
            ),
            getSearchableDropdown(_complaint, "complaint"),
            Divider(
              thickness: 1,
              height: 24,
            ),
            Text(
              "Status",
              //style: complaintCardHeading,
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                InkWell(
                    onTap: () {
                      setState(() {
                        List temp = [];
                        temp = _onTapColorStatus(cRaised, primaryorange);
                        cRaised = temp[0];
                        wRaised = temp[1];
                      });
                    },
                    child: Tag(
                      color: cRaised,
                      text: "RAISED",
                      textColor: wRaised,
                      type: TagType.DEFAULT,
                    )),
                Spacer(),
                InkWell(
                    onTap: () {
                      setState(() {
                        List temp = [];
                        temp = _onTapColorStatus(cProgress, progressYellow);
                        cProgress = temp[0];
                        wProgress = temp[1];
                      });
                    },
                    child: Tag(
                      color: cProgress,
                      text: "IN PROGRESS",
                      textColor: wProgress,
                      type: TagType.DEFAULT,
                    )),
                Spacer(),
                InkWell(
                    onTap: () {
                      setState(() {
                        List temp = [];
                        temp = _onTapColorStatus(cCompleted, primarygreen);
                        cCompleted = temp[0];
                        wCompleted = temp[1];
                      });
                    },
                    child: Tag(
                      color: cCompleted,
                      text: "COMPLETED",
                      textColor: wCompleted,
                      type: TagType.DEFAULT,
                    ))
              ],
            ),
            Divider(
              thickness: 1,
              height: 32,
            ),
            Text(
              "Date",
              //style: complaintCardHeading,
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "From",
                  style: GoogleFonts.inter(
                    textStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Spacer(),
                Text(
                  "To",
                  style: GoogleFonts.inter(
                    textStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Spacer()
              ],
            ),
            SizedBox(
              height: 4,
            ),
            Row(
              children: [
                Theme(
                data: Theme.of(context).copyWith(
                    colorScheme:
                    Theme.of(context).colorScheme.copyWith(primary: primarygreen)),
                child: Builder(
                  builder: (context) {
                    return InkWell(
                        onTap: () async {
                          final picked = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2020, 8),
                              lastDate: DateTime.now());
                          if(picked != null){
                            setState(() {
                              fromDate = picked;
                              _dateColor = Colors.black;
                            });
                          }
                        },
                        child: Container(
                          height: 45,
                          width: MediaQuery.of(context).size.width/3.15,
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(3)),
                            border: Border.all(color: Color(0xffCBD5E0), width: 0.5),
                            color: Colors.white,
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 13),
                          child: Row(
                            children: [
                              Icon(
                                FlevaIcons.calendar_outline,
                                color: Color(0xff231F20),
                              ),
                              SizedBox(width: 8,),
                              Text(fromDate.toString().substring(8, 10) +
                                  fromDate.toString().substring(4, 8) +
                                  fromDate.toString().substring(0, 4),
                                  style: GoogleFonts.inter(
                                      textStyle: TextStyle(
                                          fontFamily: 'Intern',
                                          fontSize: 14,
                                          color: _dateColor))),
                            ],
                          ),
                        ));
                  },
                ),
              ),
                SizedBox(width: MediaQuery.of(context).size.width/6,),
                Theme(
                  data: Theme.of(context).copyWith(
                      colorScheme:
                      Theme.of(context).colorScheme.copyWith(primary: primarygreen)),
                  child: Builder(
                    builder: (context) {
                      return InkWell(
                          onTap: () async {
                            final picked = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2020, 8),
                                lastDate: DateTime.now());
                            if(picked != null){
                              setState(() {
                                toDate = picked;
                                _dateColor = Colors.black;
                              });
                            }
                          },
                          child: Container(
                            height: 45,
                            width: MediaQuery.of(context).size.width/3.15,
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(3)),
                              border: Border.all(color: Color(0xffCBD5E0), width: 0.5),
                              color: Colors.white,
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 13),
                            child: Row(
                              children: [
                                Icon(
                                  FlevaIcons.calendar_outline,
                                  color: Color(0xff231F20),
                                ),
                                SizedBox(width: 8,),
                                Text(toDate.toString().substring(8, 10) +
                                    toDate.toString().substring(4, 8) +
                                    toDate.toString().substring(0, 4),
                                    style: GoogleFonts.inter(
                                        textStyle: TextStyle(
                                            fontFamily: 'Intern',
                                            fontSize: 14,
                                            color: _dateColor))),
                              ],
                            ),
                          ));
                    },
                  ),
                ),],
            ),
            Divider(
              thickness: 1,
              height: 32,
            ),
            Text(
              "Sort by",
              //style: complaintCardHeading,
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                InkWell(
                    onTap: () {
                      setState(() {
                        List temp = [];
                        temp = _onTapColorSort(cRecent, cPopular);
                        cRecent = temp[0];
                        cPopular = temp[1];
                      });
                    },
                    child: Tag(
                      color: cRecent,
                      text: "Most Recent",
                      textColor: Color(0xff252A31),
                      type: TagType.Sort,
                    )),
                SizedBox(
                  width: 28,
                ),
                InkWell(
                    onTap: () {
                      setState(() {
                        List temp = [];
                        temp = _onTapColorSort(cPopular, cRecent);
                        cPopular = temp[0];
                        cRecent = temp[1];
                      });
                    },
                    child: Tag(
                      color: cPopular,
                      text: "Most Popular",
                      textColor: Color(0xff252A31),
                      type: TagType.Sort,
                    )),
              ],
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Spacer(),
                Container(
                  height: 44,
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28),
                        side: BorderSide(color: primarygreen)),
                    color: primarygreen,
                    child: Row(
                      children: [
                        Icon(FlevaIcons.checkmark, color: Colors.white),
                        SizedBox(
                          width: 8,
                        ),
                        Text("APPLY",
                            style: GoogleFonts.inter(
                                textStyle: TextStyle(
                                    fontFamily: 'Intern',
                                    fontSize: 14,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600))),
                      ],
                    ),
                    onPressed: () {
                      //apply
                    },
                  ),
                ),
                Spacer(),
                Container(
                  height: 44,
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28),
                        side: BorderSide(color: Color(0xff718096))),
                    color: Colors.white,
                    child: Row(
                      children: [
                        Icon(FlevaIcons.close, color: Color(0xff718096)),
                        SizedBox(
                          width: 8,
                        ),
                        Text("CANCEL",
                            style: GoogleFonts.inter(
                                textStyle: TextStyle(
                                    fontFamily: 'Intern',
                                    fontSize: 14,
                                    color: Color(0xff718096),
                                    fontWeight: FontWeight.w600))),
                      ],
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                Spacer()
              ],
            ),
          ],
        ),
      ),
    );
  }
}
