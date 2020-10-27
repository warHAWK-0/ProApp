import 'package:flutter/material.dart';

enum TagType{
  DEFAULT,Sort
}

class Tag extends StatelessWidget {
  final Color color;
  final String text;
  final Color textColor;
  final TagType type;

  Tag({
    @required this.color,
    @required this.text,
    @required this.textColor,
    @required this.type
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: type == TagType.DEFAULT ? BorderRadius.all(Radius.circular(6.0)) : BorderRadius.all(Radius.circular(12.0)),
        color: color,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0,horizontal: 8.0),
        child: Text(
          text.toUpperCase(),
          style: TextStyle(
            fontSize: 12,
            color: textColor,
            letterSpacing: 1.25,
            fontWeight: FontWeight.w600
          ),
        ),
      ),
    );
  }
}