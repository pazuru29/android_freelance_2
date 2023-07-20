import 'package:android_freelance_2/conmonents/app_text.dart';
import 'package:android_freelance_2/utils/app_colors.dart';
import 'package:android_freelance_2/utils/app_icons.dart';
import 'package:android_freelance_2/utils/app_text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class SettingsButton extends StatefulWidget {
  final String title, assetName;
  final VoidCallback? onPressed;

  const SettingsButton({
    Key? key,
    required this.title,
    required this.assetName,
    this.onPressed,
  }) : super(key: key);

  @override
  State<SettingsButton> createState() => _SettingsButtonState();
}

class _SettingsButtonState extends State<SettingsButton> {
  bool _isHighlighted = false;

  set isHighlighted(bool value) {
    setState(() {
      if (widget.onPressed != null) {
        _isHighlighted = value;
      }
    });
  }

  Color _getMainColor() {
    Color color = AppColors.purple;
    if (widget.onPressed == null) {
      color = AppColors.purple;
    } else if (_isHighlighted) {
      color = AppColors.purple.withOpacity(0.7);
    }

    return color;
  }

  Color _getChildColor() {
    Color color = AppColors.white;
    if (widget.onPressed == null) {
      color = AppColors.white;
    } else if (_isHighlighted) {
      color = AppColors.white.withOpacity(0.7);
    }

    return color;
  }

  Widget _getMainWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            SvgPicture.asset(
              widget.assetName,
              color: _getChildColor(),
            ),
            const Gap(12),
            _getTexWidget(),
          ],
        ),
        RotatedBox(
          quarterTurns: 90,
          child: SvgPicture.asset(
            AppIcons.icBack,
            height: 17,
            width: 17,
            color: _getChildColor(),
          ),
        ),
      ],
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
          height: 55,
          margin: const EdgeInsets.symmetric(horizontal: 25),
          padding: const EdgeInsets.symmetric(horizontal: 25),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            border: Border.all(color: _getMainColor(), width: 2),
            color: Colors.transparent,
          ),
          child: _getMainWidget()),
    );
  }

  AppText _getTexWidget() {
    return AppText(
      style: AppTextStyles.medium16,
      text: widget.title,
      color: _getChildColor(),
    );
  }
}
