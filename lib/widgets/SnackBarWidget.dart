import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

SnackBar getSnackBar(String content) {
  return SnackBar(
    content: Text(
      content,
      textAlign: TextAlign.center,
      style: GoogleFonts.montserrat(
        textStyle: TextStyle(
          fontSize: 16
        )
      )
    )
  );
}