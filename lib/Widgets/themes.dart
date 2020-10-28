import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
//colors
Color primarygreen = Color(0xFF20BAA2);
Color primaryorange=Color(0xffFF4128);
Color progressYellow=Color(0xFFFFD400);

//textstyle with fontsize 20
TextStyle Heading1(Color color,{fontWeight = FontWeight.w500,letterSpace = 1.0}) => GoogleFonts.inter(
    textStyle:TextStyle(
      letterSpacing: letterSpace,
      color: color,
      fontSize: 20,
      fontWeight: fontWeight,
    )
);

//textstyle with fontsize 18
TextStyle Heading2(Color color,{fontWeight = FontWeight.w500,letterSpace = 1.0}) => GoogleFonts.inter(
    textStyle: TextStyle(
      letterSpacing: letterSpace,
      color: color,
      fontSize: 18,
      fontWeight: fontWeight,
    )
);

//textstyle with fontsize 16
TextStyle Heading3(Color color,{fontWeight = FontWeight.w500}) => GoogleFonts.inter(
    textStyle:TextStyle(
        color: color,
        fontSize: 16,
        fontWeight: fontWeight,
    )
);

//textstyle with fontsize 14
TextStyle Heading4(Color color,{fontWeight = FontWeight.w500}) => GoogleFonts.inter(
    textStyle:TextStyle(
        color: color,
        fontSize: 14,
        fontWeight: fontWeight,
    )
);

//textstyle with fontsize 12
TextStyle Heading(Color color,{fontSize = 12,fontWeight = FontWeight.w500}) => GoogleFonts.inter(
    textStyle:TextStyle(
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
    )
);