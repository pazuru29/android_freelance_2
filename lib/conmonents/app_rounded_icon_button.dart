import 'package:android_freelance_2/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppRoundedIconButton extends StatefulWidget {
  final String assetName;
  final VoidCallback onPressed;

  const AppRoundedIconButton({
    required this.assetName,
    required this.onPressed,
    super.key,
  });

  @override
  State<AppRoundedIconButton> createState() => _AppRoundedIconButtonState();
}

class _AppRoundedIconButtonState extends State<AppRoundedIconButton> {
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

  Color _getChildColor() {
    Color color = AppColors.purple;
    if (_isHighlighted) {
      color = AppColors.purple.withOpacity(0.5);
    }

    return color;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      onLongPressStart: (_) async {
        _isHighlighted = true;
        do {
          widget.onPressed();
          await Future.delayed(const Duration(milliseconds: 150));
        } while (_isHighlighted);
      },
      onLongPressEnd: (_) => setState(() => _isHighlighted = false),
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
        height: 22,
        width: 22,
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: _getMainColor(),
          borderRadius: BorderRadius.circular(100),
        ),
        child: Center(
          child: SvgPicture.asset(
            widget.assetName,
            color: _getChildColor(),
          ),
        ),
      ),
    );
  }
}
