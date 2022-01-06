import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

AppBar header(BuildContext context) {
  return AppBar(
    backgroundColor: Color(0xff12928f),
    title: Padding(
      padding: EdgeInsets.fromLTRB(95.0, 0, 0, 0),
      child: Text(
        "MoBIAL",
        style: GoogleFonts.nunito(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25.0),
      ),
    ),
  );
}
