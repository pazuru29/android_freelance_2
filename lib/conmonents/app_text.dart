import 'package:android_freelance_2/utils/app_colors.dart';
import 'package:android_freelance_2/utils/app_text_style.dart';
import 'package:flutter/material.dart';

class AppText extends StatefulWidget {
  final String text;
  final AppStyle style;
  final MaterialColor color;
  final int? maxLines;
  final TextOverflow? overflow;
  final TextAlign align;
  final double? height, letterSpacing;
  final bool needShadow;

  const AppText(
      {required this.text,
      required this.style,
      this.color = AppColors.white,
      this.maxLines = 1,
      this.overflow,
      this.align = TextAlign.start,
      this.height,
      this.letterSpacing,
      this.needShadow = false,
      Key? key})
      : super(key: key);

  @override
  State<AppText> createState() => _AppTextState();
}

class _AppTextState extends State<AppText> {
  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      textAlign: widget.align,
      style: TextStyle(
        color: widget.color,
        letterSpacing: widget.letterSpacing,
        fontSize: widget.style.fontSize,
        fontWeight: widget.style.fontWeight,
        fontFamily: widget.style.fontFamily,
        height: widget.height,
        overflow: widget.overflow,
        shadows: widget.needShadow
            ? [
                Shadow(
                  offset: const Offset(0, 4),
                  blurRadius: 4,
                  color: AppColors.black.withOpacity(0.35),
                ),
              ]
            : null,
      ),
      child: Text(
        widget.text,
        maxLines: widget.maxLines,
      ),
    );
  }
}
