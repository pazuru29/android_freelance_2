import 'package:android_freelance_2/conmonents/app_text.dart';
import 'package:android_freelance_2/utils/app_colors.dart';
import 'package:android_freelance_2/utils/app_text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppButton extends StatefulWidget {
  final String title;
  final Color bgColor;
  final double? width;
  final double height, borderRadius;
  final bool needShadow;
  final VoidCallback? onPressed;
  bool isOutlined = false;

  AppButton({
    Key? key,
    required this.title,
    this.bgColor = AppColors.lightPurple,
    this.width,
    this.height = 55,
    this.needShadow = false,
    this.borderRadius = 100,
    this.onPressed,
  }) : super(key: key);

  static AppButton outlined({
    required String title,
    Color buttonColor = AppColors.lightPurple,
    double? width,
    double height = 55,
    VoidCallback? onPressed,
  }) {
    return AppButton(
      title: title,
      height: height,
      width: width,
      bgColor: buttonColor,
      onPressed: onPressed,
    )..isOutlined = true;
  }

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  bool _isHighlighted = false;

  set isHighlighted(bool value) {
    setState(() {
      if (widget.onPressed != null) {
        _isHighlighted = value;
      }
    });
  }

  Color _getMainColor() {
    Color color = widget.bgColor;
    if (widget.onPressed == null) {
      color = widget.bgColor.withOpacity(0.5);
    } else if (_isHighlighted) {
      color = widget.bgColor.withOpacity(0.7);
    }

    return color;
  }

  Widget _getMainWidget() {
    return Center(
      child: _getTexWidget(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      onTapDown: (details) {
        isHighlighted = true;
      },
      onTapUp: (details) {
        isHighlighted = false;
      },
      onTapCancel: () {
        isHighlighted = false;
      },
      child: Container(
        height: widget.height,
        width: widget.width,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          boxShadow: widget.needShadow
              ? [
                  BoxShadow(
                      color: AppColors.black.withOpacity(0.3),
                      blurRadius: 3.0,
                      spreadRadius: 0,
                      offset: const Offset(0.0, 1)),
                  BoxShadow(
                    color: AppColors.black.withOpacity(0.15),
                    blurRadius: 8.0,
                    spreadRadius: 3,
                    offset: const Offset(0.0, 4),
                  ),
                ]
              : null,
          borderRadius: BorderRadius.circular(widget.borderRadius),
          border: widget.isOutlined
              ? Border.all(color: _getMainColor(), width: 2)
              : null,
          color: widget.isOutlined ? Colors.transparent : _getMainColor(),
        ),
        child: _getMainWidget(),
      ),
    );
  }

  AppText _getTexWidget() {
    return AppText(
      style: AppTextStyles.bold17,
      text: widget.title,
      color: widget.isOutlined ? _getMainColor() : _getTextColor(),
    );
  }

  Color _getTextColor() {
    Color color = AppColors.darkPurpleText;
    if (widget.onPressed == null) {
      color = AppColors.darkPurpleText.withOpacity(0.5);
    } else if (_isHighlighted) {
      color = AppColors.darkPurpleText.withOpacity(0.7);
    }

    return color;
  }
}
