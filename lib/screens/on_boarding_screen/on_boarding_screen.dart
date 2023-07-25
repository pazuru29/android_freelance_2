import 'package:android_freelance_2/conmonents/app_button.dart';
import 'package:android_freelance_2/conmonents/app_text.dart';
import 'package:android_freelance_2/conmonents/base_screen.dart';
import 'package:android_freelance_2/controllers/navigation/app_navigator.dart';
import 'package:android_freelance_2/utils/app_images.dart';
import 'package:android_freelance_2/utils/app_strings.dart';
import 'package:android_freelance_2/utils/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoardingScreen extends BaseScreen {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends BaseScreenState<OnBoardingScreen> {
  final double _heightOfImage = 450;

  @override
  Widget buildMain(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          AppImages.imOnBoarding,
          fit: BoxFit.cover,
          height: MediaQuery.of(context).size.height / 2,
          width: MediaQuery.of(context).size.width,
        ),
        const Gap(40),
        _bodyWidget(),
      ],
    );
  }

  Widget _bodyWidget() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      height: (MediaQuery.of(context).size.height -
              (MediaQuery.of(context).padding.bottom +
                  MediaQuery.of(context).padding.top)) /
          2,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
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
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: AppButton(
              title: 'Create first match',
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.setBool('isFirstRun', false).whenComplete(() {
                  AppNavigator.replaceToHomeScreen(context);
                  AppNavigator.goToCreateNewGameScreen(context);
                });
              },
            ),
          ),
          const Gap(16),
        ],
      ),
    );
  }
}
