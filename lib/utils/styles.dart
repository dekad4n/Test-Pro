import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final appDescription = GoogleFonts.raleway(

);

final registerStyle = GoogleFonts.raleway(

);
final registerStyleGrey = GoogleFonts.raleway(
  color: Colors.grey[500]
);

final registerStyleBlue = GoogleFonts.raleway(
  color: Colors.blueAccent
);
final buttonWhiteStyle = GoogleFonts.raleway(
  color: Colors.white
);
final personalInfoStyle = GoogleFonts.raleway(
    fontSize: 24,
    fontWeight: FontWeight.w500
);
final errorStyle = GoogleFonts.raleway(
  color: Colors.red,
  fontSize: 56
);

final enabledBorderStyle = OutlineInputBorder(
  borderRadius: const BorderRadius.all(Radius.circular(20)),
  borderSide: BorderSide(
    color: Colors.grey[400]!
  )
);

const errorBorderStyle = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(20)),
    borderSide: BorderSide(
        color: Colors.red
    )
);