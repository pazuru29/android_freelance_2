import 'package:android_freelance_2/conmonents/app_text.dart';
import 'package:android_freelance_2/conmonents/base_screen.dart';
import 'package:android_freelance_2/utils/app_images.dart';
import 'package:android_freelance_2/utils/app_strings.dart';
import 'package:android_freelance_2/utils/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class OnBoardingScreen extends BaseScreen {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends BaseScreenState<OnBoardingScreen> {
  @override
  Widget buildMain(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(AppImages.imOnBoarding),
        const Gap(40),
        _bodyWidget(),
      ],
    );
  }

  Widget _bodyWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AppText(
            text: AppStrings.helloText,
            style: AppTextStyles.bold30,
          ),
          const Gap(7),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Image.asset(AppImages.imLine),
          ),
          const Gap(15),
          const AppText(
            text: AppStrings.descriptionOnBoarding,
            style: AppTextStyles.regular17,
            maxLines: null,
          ),
          const Gap(25),
          const AppText(
            text: AppStrings.endText,
            style: AppTextStyles.semiBold17,
          ),
        ],
      ),
    );
  }
}
