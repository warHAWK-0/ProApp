import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
//colors
Color primarygreen = Color(0xFF20BAA2);
Color primaryorange=Color(0xffFF4128);

//textstyle with fontsize 20
TextStyle Heading1(Color color) => GoogleFonts.inter(
    textStyle:TextStyle(
        color: color,
        fontSize: 20,
        fontWeight: FontWeight.w600
    )
);

//textstyle with fontsize 18
TextStyle Heading2(Color color) => GoogleFonts.inter(
    textStyle:TextStyle(
        color: color,
        fontSize: 18,
        fontWeight: FontWeight.w600
    )
);

//textstyle with fontsize 16
TextStyle Heading3(Color color) => GoogleFonts.inter(
    textStyle:TextStyle(
        color: color,
        fontSize: 16,
        fontWeight: FontWeight.w500
    )
);

//textstyle with fontsize 14
TextStyle Heading4(Color color) => GoogleFonts.inter(
    textStyle:TextStyle(
        color: color,
        fontSize: 14,
        fontWeight: FontWeight.w400,
    )
);