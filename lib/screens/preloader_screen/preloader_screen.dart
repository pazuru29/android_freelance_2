import 'dart:async';

import 'package:android_freelance_2/conmonents/base_screen.dart';
import 'package:android_freelance_2/controllers/navigation/app_navigator.dart';
import 'package:android_freelance_2/main.dart';
import 'package:android_freelance_2/utils/app_colors.dart';
import 'package:android_freelance_2/utils/app_images.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class PreloaderScreen extends BaseScreen {
  const PreloaderScreen({super.key});

  @override
  State<PreloaderScreen> createState() => _PreloaderScreenState();
}

class _PreloaderScreenState extends BaseScreenState<PreloaderScreen> {
  double progressValue = 0;

  @override
  void initState() {
    _getProgress();
    super.initState();
  }

  @override
  Widget buildMain(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Image.asset(AppImages.imPreloader),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 150),
                child: Image.asset(
                  AppImages.imLogo,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(45, 68, 45, 0),
                child: LinearPercentIndicator(
                  lineHeight: 12,
                  percent: progressValue >= 1 ? 1 : progressValue,
                  barRadius: const Radius.circular(100),
                  progressColor: AppColors.white,
                  backgroundColor: AppColors.purple,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _getProgress() {
    Timer.periodic(const Duration(milliseconds: 10), (timer) {
      setState(() {
        if (progressValue < 1) {
          progressValue += 0.01;
        } else {
          timer.cancel();
          if (isFirstRun) {
            AppNavigator.replaceToOnBoardingScreen();
          } else {
            AppNavigator.replaceToHomeScreen();
          }
        }
      });
    });
  }
}
