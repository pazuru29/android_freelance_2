import 'package:android_freelance_2/conmonents/app_text.dart';
import 'package:android_freelance_2/utils/app_colors.dart';
import 'package:android_freelance_2/utils/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class DropDownMenuButton extends StatefulWidget {
  final String title;
  final String? assetName;
  final VoidCallback onPressed;
  final bool isSelectedItem;
  final double height;

  const DropDownMenuButton({
    required this.title,
    required this.assetName,
    required this.isSelectedItem,
    required this.onPressed,
    this.height = 48,
    super.key,
  });

  @override
  State<DropDownMenuButton> createState() => _DropDownMenuButtonState();
}

class _DropDownMenuButtonState extends State<DropDownMenuButton> {
  bool _isHighlighted = false;

  set isHighlighted(bool value) {
    setState(() {
      _isHighlighted = value;
    });
  }

  Color _getMainColor() {
    Color color = AppColors.white;
    if (widget.isSelectedItem) {
      color = AppColors.white.withOpacity(0.5);
    } else if (_isHighlighted) {
      color = AppColors.white.withOpacity(0.7);
    }

    return color;
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
        color: Colors.transparent,
        padding: const EdgeInsets.symmetric(horizontal: 25),
        height: widget.height,
        child: Row(
          mainAxisAlignment: widget.assetName != null
              ? MainAxisAlignment.start
              : MainAxisAlignment.center,
          children: [
            if (widget.assetName != null)
              SvgPicture.asset(
                widget.assetName!,
                color: _getMainColor(),
              ),
            if (widget.assetName != null) const Gap(8),
            FittedBox(
              child: AppText(
                text: widget.title,
                style: AppTextStyles.regular16,
                color: _getMainColor(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
