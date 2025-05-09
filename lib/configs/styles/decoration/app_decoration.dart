// ignore_for_file: library_private_types_in_public_api

import 'package:tester/configs/styles/colors/app_colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import "package:tester/configs/styles/dimensions/app_dimensions.dart";
import 'package:tester/configs/styles/text_styles/app_text_styles.dart';


part 'app_decoration_button.dart';
part 'app_decoration_input.dart';
part 'app_decoration_elevated_button.dart';

class AppDecoration {
  const AppDecoration._();

  static const _Button button = _Button();
  static const _Input input = _Input();
  static const _ElevatedButtonStyle elevated = _ElevatedButtonStyle();
}