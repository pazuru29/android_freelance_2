import 'package:android_freelance_2/conmonents/base_screen.dart';
import 'package:android_freelance_2/conmonents/third_app_bar.dart';
import 'package:android_freelance_2/screens/privacy_policy_screen/widgets/title_text_widget.dart';
import 'package:android_freelance_2/utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class TermsOfUseScreen extends BaseScreen {
  const TermsOfUseScreen({super.key});

  @override
  State<TermsOfUseScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends BaseScreenState<TermsOfUseScreen> {
  @override
  Widget buildMain(BuildContext context) {
    return const SafeArea(
      child: Column(
        children: [
          ThirdAppBar(title: AppStrings.termsOfUse),
          Flexible(
            child: CustomScrollView(
              shrinkWrap: true,
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25),
                    child: Column(
                      children: [
                        Gap(16),
                        TitleTextWidget(
                          title: AppStrings.titlePrivacyPolicy,
                          subtitle: AppStrings.subtitlePrivacyPolicy,
                        ),
                        Gap(15),
                        TitleTextWidget(
                          title: AppStrings.titlePrivacyPolicy,
                          subtitle: AppStrings.subtitlePrivacyPolicy,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
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
