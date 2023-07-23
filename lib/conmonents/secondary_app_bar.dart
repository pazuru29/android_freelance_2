import 'package:android_freelance_2/conmonents/app_text.dart';
import 'package:android_freelance_2/controllers/navigation/app_navigator.dart';
import 'package:android_freelance_2/utils/app_colors.dart';
import 'package:android_freelance_2/utils/app_icons.dart';
import 'package:android_freelance_2/utils/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class SecondaryAppBar extends StatelessWidget {
  final String titleBack, title;
  final Widget? child;
  final String? subtitle;

  const SecondaryAppBar({
    required this.title,
    required this.titleBack,
    this.child,
    this.subtitle,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(25, 11, 25, 8),
      color: Colors.transparent,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: (){
                  AppNavigator.goBack(context);
                },
                child: Container(
                  color: Colors.transparent,
                  child: Row(
                    children: [
                      SvgPicture.asset(AppIcons.icBack),
                      const Gap(9),
                      AppText(
                        text: titleBack,
                        style: AppTextStyles.medium17,
                        color: AppColors.lightPurple,
                      ),
                    ],
                  ),
                ),
              ),
              if (child != null) child!,
            ],
          ),
          const Gap(20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText(
                text: title,
                style: AppTextStyles.bold35,
              ),
              if (subtitle != null)
                AppText(
                  text: subtitle!,
                  style: AppTextStyles.regular21,
                ),
            ],
          ),
        ],
      ),
    );
  }
}
