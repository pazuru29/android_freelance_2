import 'package:android_freelance_2/conmonents/app_button.dart';
import 'package:android_freelance_2/conmonents/app_icon_button.dart';
import 'package:android_freelance_2/conmonents/app_text.dart';
import 'package:android_freelance_2/conmonents/base_screen.dart';
import 'package:android_freelance_2/conmonents/main_app_bar.dart';
import 'package:android_freelance_2/controllers/home_controller/home_controller.dart';
import 'package:android_freelance_2/controllers/navigation/app_navigator.dart';
import 'package:android_freelance_2/screens/home_screen/widgets/match_card.dart';
import 'package:android_freelance_2/utils/app_colors.dart';
import 'package:android_freelance_2/utils/app_icons.dart';
import 'package:android_freelance_2/utils/app_strings.dart';
import 'package:android_freelance_2/utils/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class HomeScreen extends BaseScreen {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends BaseScreenState<HomeScreen>
    with TickerProviderStateMixin {
  late final HomeController _homeController;

  late final TabController _tabController;

  @override
  void initState() {
    _homeController = Get.put(
      HomeController(),
      permanent: true,
    );
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget buildMain(BuildContext context) {
    return SafeArea(
      child: Obx(
        () => Column(
          children: [
            MainAppBar(
              title: 'Matches',
              child: AppIconButton(
                assetName: AppIcons.icSettings,
                onPressed: () {
                  AppNavigator.goToSettingsScreen();
                },
              ),
            ),
            const Gap(28),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 25),
              decoration: BoxDecoration(
                  color: AppColors.backgroundActivity,
                  borderRadius: BorderRadius.circular(100)),
              child: TabBar(
                dividerColor: Colors.transparent,
                controller: _tabController,
                indicatorColor: AppColors.lightPurple,
                onTap: (index) => setState(() {}),
                tabs: [
                  Tab(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      color: Colors.transparent,
                      child: AppText(
                        text: 'Active',
                        style: AppTextStyles.semiBold16,
                        color: _tabController.index == 0
                            ? AppColors.white
                            : AppColors.purple,
                      ),
                    ),
                  ),
                  Tab(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      color: Colors.transparent,
                      child: AppText(
                        text: 'Finished',
                        style: AppTextStyles.semiBold16,
                        color: _tabController.index == 1
                            ? AppColors.white
                            : AppColors.purple,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Gap(25),
            Flexible(
              child: TabBarView(
                controller: _tabController,
                children: [
                  ListView.builder(
                    physics: const ClampingScrollPhysics(),
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemCount: _homeController.listOfActiveMatches.isEmpty
                        ? 0
                        : _homeController.listOfActiveMatches.length + 1,
                    itemBuilder: (context, index) {
                      if (index == _homeController.listOfActiveMatches.length) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 25,
                            vertical: 16,
                          ),
                          child: AppButton.outlined(
                            title: AppStrings.btnCreateNewMatch,
                            onPressed: () {
                              AppNavigator.goToCreateNewGameScreen();
                            },
                          ),
                        );
                      }
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: MatchCard(
                          matchModel: _homeController.listOfActiveMatches[index],
                        ),
                      );
                    },
                  ),
                  Container(),
                ],
              ),
            ),
            if (_homeController.listOfActiveMatches.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 25,
                  vertical: 16,
                ),
                child: AppButton.outlined(
                  title: AppStrings.btnCreateNewMatch,
                  onPressed: () {
                    AppNavigator.goToCreateNewGameScreen();
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  bool needScroll() {
    return false;
  }
}
