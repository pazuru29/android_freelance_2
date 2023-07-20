import 'package:android_freelance_2/conmonents/app_text.dart';
import 'package:android_freelance_2/utils/app_colors.dart';
import 'package:android_freelance_2/utils/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class AppRadioButton extends StatelessWidget {
  final String title;
  final int value;
  final int groupValue;
  final Function(int) onPressed;

  const AppRadioButton({
    required this.title,
    required this.value,
    required this.groupValue,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onPressed(value);
      },
      child: Container(
        color: Colors.transparent,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 30,
              width: 30,
              padding: const EdgeInsets.all(7),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(100),
              ),
              child: groupValue == value
                  ? Container(
                      decoration: BoxDecoration(
                        color: AppColors.backgroundActivity,
                        borderRadius: BorderRadius.circular(100),
                      ),
                    )
                  : null,
            ),
            const Gap(20),
            AppText(
              text: title,
              style: AppTextStyles.semiBold17,
            )
          ],
        ),
      ),
    );
  }
}
