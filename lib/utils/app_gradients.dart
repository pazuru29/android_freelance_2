import 'package:android_freelance_2/utils/app_colors.dart';
import 'package:flutter/cupertino.dart';

class AppGradients {
  static const LinearGradient backgroundGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      AppColors.darkBlue,
      AppColors.blue,
    ],
  );
}
