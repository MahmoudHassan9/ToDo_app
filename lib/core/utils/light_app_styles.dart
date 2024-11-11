import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/utils/app_colors.dart';
import 'package:todo_app/providers/settings_tab_provider.dart';

abstract class LightAppStyles {
  static TextStyle appBar = GoogleFonts.poppins(
    fontSize: 22.sp,
    fontWeight: FontWeight.w700,
    color: AppColors.white,
  );
  static TextStyle settingsTabLabel = GoogleFonts.poppins(
    fontSize: 17.sp,
    fontWeight: FontWeight.w700,
    color: Colors.black,
  );
  static TextStyle settingsTabListTileTitle = GoogleFonts.inter(
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.blue,
  );
  static TextStyle poppinsFontWeight700Size18 = GoogleFonts.poppins(
    fontSize: 18.sp,
    fontWeight: FontWeight.w700,
    color: Colors.blue,
  );

  static TextStyle hintText = GoogleFonts.inter(
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
  );
  static TextStyle buttonText = GoogleFonts.poppins(
    fontSize: 16.sp,
    fontWeight: FontWeight.w700,
  );
  static TextStyle taskItemDesc = GoogleFonts.roboto(
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );
  static TextStyle activeCalenderDayMonth = GoogleFonts.roboto(
    fontSize: 12.sp,
    color: AppColors.blue,
    fontWeight: FontWeight.w500,
  );
  static TextStyle activeCalenderDayNum = GoogleFonts.roboto(
    fontSize: 18.sp,
    fontWeight: FontWeight.w900,
    color: AppColors.blue,
  );
  static TextStyle activeCalendarDayStr = GoogleFonts.roboto(
    fontSize: 12.sp,
    color: AppColors.blue,
    fontWeight: FontWeight.w500,
  );
  static TextStyle inactiveCalenderDayMonth = GoogleFonts.roboto(
    fontSize: 12.sp,
    color: AppColors.black,
    fontWeight: FontWeight.w500,
  );
  static TextStyle inactiveCalenderDayNum = GoogleFonts.roboto(
    fontSize: 18.sp,
    fontWeight: FontWeight.w900,
    color: AppColors.black,
  );
  static TextStyle inactiveCalendarDayStr = GoogleFonts.roboto(
    fontSize: 12.sp,
    color: AppColors.black,
    fontWeight: FontWeight.w500,
  );
}
