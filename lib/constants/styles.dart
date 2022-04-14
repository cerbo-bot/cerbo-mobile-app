import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color PrimaryColor = Color(0xFF4173FE);
const Color SecondaryColor = Color(0xFFf1f2f6);
const Color TextColorDark = Colors.black;
const Color TextColorUnSelected = Color(0xFFBFBFBF);
const Color TextColorLight = Colors.white;
const Color Grey = Colors.grey;
Color titleColor = Colors.grey.shade700;

// Base styles according to material design
var heading1 =
    GoogleFonts.roboto(fontSize: 96, color: TextColorDark, letterSpacing: -1.5);
var heading2 =
    GoogleFonts.roboto(fontSize: 60, color: TextColorDark, letterSpacing: -0.5);
var heading3 =
    GoogleFonts.roboto(fontSize: 48, color: TextColorDark, letterSpacing: 0);
var heading4 =
    GoogleFonts.roboto(fontSize: 34, color: TextColorDark, letterSpacing: 0.25);
var heading5 =
    GoogleFonts.roboto(fontSize: 24, color: TextColorDark, letterSpacing: 0);
var heading6 =
    GoogleFonts.roboto(fontSize: 20, color: TextColorDark, letterSpacing: 0.15);
var heading7 =
    GoogleFonts.roboto(fontSize: 18, color: TextColorDark, letterSpacing: 0.15);
var subtitle1 =
    GoogleFonts.roboto(fontSize: 16, color: TextColorDark, letterSpacing: 0.15);
var subtitle2 =
    GoogleFonts.roboto(fontSize: 14, color: TextColorDark, letterSpacing: 0.1);
var body1 =
    GoogleFonts.roboto(fontSize: 16, color: TextColorDark, letterSpacing: 0.5);
var body2 =
    GoogleFonts.roboto(fontSize: 14, color: TextColorDark, letterSpacing: 0.25);
var caption =
    GoogleFonts.roboto(fontSize: 12, color: TextColorDark, letterSpacing: 0.4);
var overline =
    GoogleFonts.roboto(fontSize: 10, color: TextColorDark, letterSpacing: 1.5);

// Custom font
var heading5Bold = heading5.copyWith(fontWeight: FontWeight.bold);
var heading5Light = heading5.copyWith(color: TextColorUnSelected);
var heading6Bold = heading6.copyWith(fontWeight: FontWeight.bold);
var heading6Light = heading6.copyWith(color: TextColorUnSelected);
var subtitle2Bold = subtitle2.copyWith(fontWeight: FontWeight.bold);
var subtitle2Light = subtitle2.copyWith(color: TextColorUnSelected);
var body1Light = body1.copyWith(color: TextColorUnSelected);
var body2Light = body2.copyWith(color: TextColorUnSelected);
var body2Title = body2.copyWith(color: titleColor);
var captionBold = caption.copyWith(fontWeight: FontWeight.bold);
var captionLight = caption.copyWith(color: TextColorUnSelected);
