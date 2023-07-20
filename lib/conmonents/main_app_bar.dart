import 'package:android_freelance_2/conmonents/app_text.dart';
import 'package:android_freelance_2/utils/app_text_style.dart';
import 'package:flutter/material.dart';

class MainAppBar extends StatelessWidget {
  final String title;
  final Widget? child;

  const MainAppBar({
    required this.title,
    this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(25, 25, 25, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppText(
            text: title,
            style: AppTextStyles.bold35,
          ),
          if (child != null) child!,
        ],
      ),
    );
  }
}
