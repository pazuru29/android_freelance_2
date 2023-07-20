import 'package:android_freelance_2/conmonents/app_text.dart';
import 'package:android_freelance_2/controllers/navigation/app_navigator.dart';
import 'package:android_freelance_2/utils/app_colors.dart';
import 'package:android_freelance_2/utils/app_icons.dart';
import 'package:android_freelance_2/utils/app_strings.dart';
import 'package:android_freelance_2/utils/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:measure_size/measure_size.dart';

class ThirdAppBar extends StatefulWidget {
  final String title;

  const ThirdAppBar({required this.title, super.key});

  @override
  State<ThirdAppBar> createState() => _ThirdAppBarState();
}

class _ThirdAppBarState extends State<ThirdAppBar> {
  double _backWidth = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      padding: const EdgeInsets.fromLTRB(25, 11, 25, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              AppNavigator.goBack();
            },
            child: MeasureSize(
              onChange: (size) {
                setState(() {
                  _backWidth = size.width;
                });
              },
              child: Container(
                color: Colors.transparent,
                child: Row(
                  children: [
                    SvgPicture.asset(AppIcons.icBack),
                    const Gap(9),
                    const AppText(
                      text: AppStrings.btnBack,
                      style: AppTextStyles.medium17,
                      color: AppColors.lightPurple,
                    ),
                  ],
                ),
              ),
            ),
          ),
          AppText(text: widget.title, style: AppTextStyles.bold21),
          Gap(_backWidth),
        ],
      ),
    );
  }
}
