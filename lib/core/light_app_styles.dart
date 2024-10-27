import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/core/app_colors.dart';

class LightAppStyles {
  static TextStyle appBar = GoogleFonts.poppins(
    fontSize: 22,
    fontWeight: FontWeight.w700,
    color: AppColors.white,
  );
  static TextStyle settingsTabLabel = GoogleFonts.poppins(
    fontSize: 17,
    fontWeight: FontWeight.w700,
    color: Colors.black,
  );
  static TextStyle settingsTabListTileTitle = GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.blue,
  );
}
