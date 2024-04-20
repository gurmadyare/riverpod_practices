import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyFont extends StatelessWidget {
  final String text;
  final double? size;
  final FontWeight? fontWeight;
  final Color? color;

  const MyFont(
      {super.key,
      required this.text,
      this.size = 18,
      this.fontWeight = FontWeight.w400,
      this.color = Colors.white});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.poppins(
        fontSize: size,
        fontWeight: fontWeight,
        color: color,
      ),
    );
  }
}
