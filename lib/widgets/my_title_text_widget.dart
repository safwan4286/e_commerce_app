import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTitleTextWidget extends StatelessWidget {
  const MyTitleTextWidget({super.key, required this.text, required this.color});
  final String text;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.lato(
          textStyle: TextStyle(
              fontSize: 30, fontWeight: FontWeight.bold, color: color)),
    );
  }
}
