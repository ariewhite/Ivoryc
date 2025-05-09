// ignore_for_file: library_private_types_in_public_api

import 'package:tester/configs/styles/colors/app_colors.dart';
import 'package:flutter/material.dart';

part 'app_text_styles_button.dart';

class AppTextStyles {
  const AppTextStyles._();

  static const _Button button = _Button();

  static TextStyle defaultStyle() => const TextStyle(
        fontFamily: 'Cascadia',
        letterSpacing: 0.2,
      );

  static TextStyle h1() => defaultStyle().copyWith(
        color: AppColors.black,
        fontSize: 28.0,
        fontWeight: FontWeight.bold,
        fontFamily: "Cascadia",
      );

  static TextStyle h2() => defaultStyle().copyWith(
        color: AppColors.black,
        fontSize: 24.0,
        fontWeight: FontWeight.bold,
        fontFamily: "Cascadia",
      );

  static TextStyle h3() => defaultStyle().copyWith(
        color: AppColors.black,
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
        fontFamily: "Cascadia",
      );

  static TextStyle h4() => defaultStyle().copyWith(
        color: AppColors.black,
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
        fontFamily: "Cascadia",
      );

  static TextStyle h5() => defaultStyle().copyWith(
        color: AppColors.black,
        fontSize: 16.0,
        fontWeight: FontWeight.bold,
        fontFamily: "Cascadia",
      );

  static TextStyle h6() => defaultStyle().copyWith(
        color: AppColors.black,
        fontSize: 14.0,
        fontWeight: FontWeight.bold,
        fontFamily: "Cascadia",
      );

  static TextStyle text1() => defaultStyle().copyWith(
        color: AppColors.black,
        fontSize: 16.0,
        fontWeight: FontWeight.normal,
        fontFamily: "Cascadia",
      );

  static TextStyle text2() => defaultStyle().copyWith(
        color: AppColors.black,
        fontSize: 14.0,
        fontWeight: FontWeight.normal,
        fontFamily: "Cascadia",
      );

  static TextStyle caption1() => defaultStyle().copyWith(
        color: AppColors.black,
        fontSize: 14.0,
        fontWeight: FontWeight.w500,
        fontFamily: "Cascadia",
      );

  static TextStyle caption1Bold() => defaultStyle().copyWith(
        color: AppColors.black,
        fontSize: 14.0,
        fontWeight: FontWeight.bold,
        fontFamily: "Cascadia",
      );

  static TextStyle caption2() => defaultStyle().copyWith(
        color: AppColors.black,
        fontSize: 12.0,
        fontWeight: FontWeight.w500,
        fontFamily: "Cascadia",
      );

  static TextStyle caption2Bold() => defaultStyle().copyWith(
        color: AppColors.black,
        fontSize: 12.0,
        fontWeight: FontWeight.bold,
        fontFamily: "Cascadia",
      );

  static TextStyle caption3() => defaultStyle().copyWith(
        color: AppColors.black,
        fontSize: 10.0,
        fontWeight: FontWeight.w500,
        fontFamily: "Cascadia",
      );

  static TextStyle caption3Bold() => defaultStyle().copyWith(
        color: AppColors.black,
        fontSize: 10.0,
        fontWeight: FontWeight.bold,
        fontFamily: "Cascadia",
      );

  static TextStyle caption4Bold() => defaultStyle().copyWith(
        color: AppColors.white,
        fontSize: 8.0,
        fontWeight: FontWeight.bold,
        fontFamily: "Cascadia",
      );

  static TextStyle blackButton() => defaultStyle().copyWith(
        fontSize: 14.0,
        fontWeight: FontWeight.bold,
        fontFamily: "Cascadia",
      );
}