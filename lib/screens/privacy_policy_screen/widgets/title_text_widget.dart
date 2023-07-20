import 'package:android_freelance_2/conmonents/app_text.dart';
import 'package:android_freelance_2/utils/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class TitleTextWidget extends StatelessWidget {
  final String title, subtitle;

  const TitleTextWidget({
    required this.title,
    required this.subtitle,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          text: title,
          style: AppTextStyles.regular17,
          maxLines: null,
        ),
        const Gap(17),
        AppText(
          text: subtitle,
          style: AppTextStyles.regular14,
          maxLines: null,
        ),
      ],
    );
  }
}
