import 'dart:ui';

class AppTextStyles {
  //Regular
  static const AppStyle regular17 = AppStyle(
    fontSize: 17,
    fontWeight: FontWeight.w400,
  );

  //Medium
  static const AppStyle medium20 = AppStyle(
    fontSize: 20,
    fontWeight: FontWeight.w500,
  );

  static const AppStyle medium33 = AppStyle(
    fontSize: 33,
    fontWeight: FontWeight.w500,
  );

  static const AppStyle medium80 = AppStyle(
    fontSize: 80,
    fontWeight: FontWeight.w500,
  );

  //semiBold
  static const AppStyle semiBold17 = AppStyle(
    fontSize: 17,
    fontWeight: FontWeight.w600,
  );

  static const AppStyle semiBold20 = AppStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
  );

  static const AppStyle semiBold54 = AppStyle(
    fontSize: 54,
    fontWeight: FontWeight.w600,
  );

  //Bold
  static const AppStyle bold30 = AppStyle(
    fontSize: 30,
    fontWeight: FontWeight.w700,
  );

  static const AppStyle bold17 = AppStyle(
    fontSize: 17,
    fontWeight: FontWeight.w700,
  );
}

class AppStyle {
  final double fontSize;
  final FontWeight fontWeight;
  final String fontFamily;

  const AppStyle({
    required this.fontSize,
    required this.fontWeight,
    this.fontFamily = 'Raleway',
  });
}
