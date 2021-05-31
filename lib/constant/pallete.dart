import 'package:flutter/material.dart';

class Pallete {
  static const Color bgColor = Color(0xff02df83);
  static const MaterialColor mbgcolor = const MaterialColor(
    0xff02df83,
    const <int, Color>{
      50: const Color(0xff02df83),
      100: const Color(0xff02df83),
      200: const Color(0xff02df83),
      300: const Color(0xff02df83),
      400: const Color(0xff02df83),
      500: const Color(0xff02df83),
      600: const Color(0xff02df83),
      700: const Color(0xff02df83),
      800: const Color(0xff02df83),
      900: const Color(0xff02df83),
    },
  );
  static const Color knav = Color(0xffd9ed92);
  static const kheading = TextStyle(
      fontSize: 25,
      fontFamily: 'Poppins',
      color: Colors.white,
      fontWeight: FontWeight.bold);
  static const kpara = TextStyle(
    fontSize: 18,
    fontFamily: 'Poppins',
    color: Colors.white,
  );
  static const khint = TextStyle(
    fontFamily: 'Poppins',
    color: Colors.black54,
  );
  static const kpopbtn = TextStyle(
      fontSize: 18,
      fontFamily: 'Poppins',
      color: bgColor,
      fontWeight: FontWeight.bold);
  static const kbtn = TextStyle(
    fontSize: 20,
    fontFamily: 'Poppins',
    color: Colors.white,
    fontWeight: FontWeight.bold,
  );
  static const kbtn2 = TextStyle(
    fontSize: 20,
    fontFamily: 'Poppins',
    color: bgColor,
    fontWeight: FontWeight.bold,
  );
  static const knavunselected = TextStyle(
    fontSize: 15,
    fontFamily: 'Poppins',
  );
  static const knavselected = TextStyle(
    fontSize: 18,
    fontFamily: 'Poppins',
  );
}
