import 'package:android_freelance_2/conmonents/base_screen.dart';
import 'package:android_freelance_2/conmonents/secondary_app_bar.dart';
import 'package:android_freelance_2/controllers/navigation/app_navigator.dart';
import 'package:android_freelance_2/screens/settings_screen/widgets/settings_button.dart';
import 'package:android_freelance_2/utils/app_icons.dart';
import 'package:android_freelance_2/utils/app_strings.dart';
import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class SettingsScreen extends BaseScreen {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends BaseScreenState<SettingsScreen> {
  @override
  Widget buildMain(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const SecondaryAppBar(
            title: 'Settings',
            titleBack: AppStrings.btnBack,
          ),
          const Gap(48),
          SettingsButton(
            title: 'Notifications',
            assetName: AppIcons.icVolume,
            onPressed: () {
              AppSettings.openAppSettings(type: AppSettingsType.settings);
            },
          ),
          const Gap(12),
          SettingsButton(
            title: 'Privacy Policy',
            assetName: AppIcons.icColumnist,
            onPressed: () {
              AppNavigator.goToPrivacyPolicyScreen();
            },
          ),
          const Gap(12),
          SettingsButton(
            title: 'Terms of Use',
            assetName: AppIcons.icPapers,
            onPressed: () {
              AppNavigator.goToTermsOfUseScreen();
            },
          ),
        ],
      ),
    );
  }

  @override
  bool needScroll() {
    return false;
  }
}
