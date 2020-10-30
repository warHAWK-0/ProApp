import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:proapp/Widgets/themes.dart';

class CustomAppBar extends PreferredSize {
  final bool backIcon;
  final Widget child;
  final bool elevation;

  @override
  final Size preferredSize;

  CustomAppBar({
    this.backIcon = true,
    @required this.child,
    this.elevation = true
  }) : assert(child != null),
        preferredSize = Size.fromHeight(56.0);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      child: Container(
        padding: EdgeInsets.only(left: 10,bottom: 5),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              //spreadRadius: 0.5,
              blurRadius: 2,
              offset: Offset(0, 1), // changes position of shadow
            ),
          ],
        ),

        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: child,
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: backIcon == true ? GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 14,left: 12),
                  child: Icon(Icons.arrow_back_ios,color: primarygreen,size: 20,),
                ),
              ) : Container(                          //logo
                width: 38,
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(''),fit: BoxFit.fill,
                    )
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}