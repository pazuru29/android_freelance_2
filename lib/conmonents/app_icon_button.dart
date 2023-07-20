import 'package:android_freelance_2/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppIconButton extends StatefulWidget {
  final String assetName;
  final VoidCallback onPressed;

  const AppIconButton({
    required this.assetName,
    required this.onPressed,
    super.key,
  });

  @override
  State<AppIconButton> createState() => _AppIconButtonState();
}

class _AppIconButtonState extends State<AppIconButton> {
  bool _isHighlighted = false;

  set isHighlighted(bool value) {
    setState(() {
      _isHighlighted = value;
    });
  }

  Color _getMainColor() {
    Color color = AppColors.white;
    if (_isHighlighted) {
      color = AppColors.white.withOpacity(0.5);
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
        height: 44,
        width: 44,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: AppColors.backgroundActivity,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                blurRadius: 6,
                offset: const Offset(0, 3),
                color: AppColors.black.withOpacity(0.18),
              )
            ]),
        child: Center(
          child: SvgPicture.asset(
            widget.assetName,
            color: _getMainColor(),
          ),
        ),
      ),
    );
  }
}
