import 'package:android_freelance_2/conmonents/app_button.dart';
import 'package:android_freelance_2/conmonents/app_rounded_icon_button.dart';
import 'package:android_freelance_2/conmonents/app_text.dart';
import 'package:android_freelance_2/conmonents/base_screen.dart';
import 'package:android_freelance_2/conmonents/secondary_app_bar.dart';
import 'package:android_freelance_2/data/database/models/match_model.dart';
import 'package:android_freelance_2/utils/app_colors.dart';
import 'package:android_freelance_2/utils/app_icons.dart';
import 'package:android_freelance_2/utils/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class GameScreen extends BaseScreen {
  final MatchModel matchModel;

  const GameScreen({
    required this.matchModel,
    super.key,
  });

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends BaseScreenState<GameScreen> {

  @override
  Widget buildMain(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SecondaryAppBar(
            title: _getGameTypeName(),
            titleBack: 'Back to matches',
            subtitle: widget.matchModel.name ?? 'My game',
            child: GestureDetector(
              onTap: () {},
              child: SvgPicture.asset(AppIcons.icMore),
            ),
          ),
          _scoreWidget(),
          const Gap(45),
          _rulesWidget(),
          Padding(
            padding: const EdgeInsets.fromLTRB(25, 35, 25, 45),
            child: AppButton(
              title: 'Start Game',
              bgColor: AppColors.green,
              onPressed: () {},
            ),
          ),
          _history(),
        ],
      ),
    );
  }

  Widget _scoreWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Gap(17),
          const AppText(
            text: 'Score',
            style: AppTextStyles.bold21,
          ),
          const Gap(15),
          _teamScore(
              1, widget.matchModel.nameTeam1, widget.matchModel.scoreTeam1),
          const Gap(10),
          _teamScore(
              2, widget.matchModel.nameTeam2, widget.matchModel.scoreTeam2),
        ],
      ),
    );
  }

  Widget _teamScore(int numberOfTeam, String nameOfTeam, int scoreOfTeam) {
    return Row(
      children: [
        Container(
          height: 55,
          width: 38,
          decoration: BoxDecoration(
            color: AppColors.purple,
            borderRadius: BorderRadius.circular(100),
          ),
          child: Center(
            child: AppText(
              text: '$numberOfTeam',
              style: AppTextStyles.regular30,
            ),
          ),
        ),
        const Gap(12),
        Flexible(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            height: 55,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(100),
              border: Border.all(
                color: AppColors.purple,
                width: 2,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: FittedBox(
                    child: AppText(
                      text: nameOfTeam,
                      style: AppTextStyles.medium16,
                    ),
                  ),
                ),
                const Gap(4),
                Row(
                  children: [
                    AppRoundedIconButton(
                      assetName: AppIcons.icMinus,
                      onPressed: () {},
                    ),
                    const Gap(2),
                    SizedBox(
                      width: 44,
                      child: Center(
                        child: FittedBox(
                          child: AppText(
                            text: '$scoreOfTeam',
                            style: AppTextStyles.semiBold17,
                          ),
                        ),
                      ),
                    ),
                    const Gap(2),
                    AppRoundedIconButton(
                      assetName: AppIcons.icPlus,
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _rulesWidget() {
    if (widget.matchModel.maxScore != null) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(text: 'Rules', style: AppTextStyles.bold21),
                Gap(8),
                AppText(text: 'Max score', style: AppTextStyles.regular17),
              ],
            ),
            Container(
              height: 55,
              width: 112,
              decoration: BoxDecoration(
                color: AppColors.purple,
                borderRadius: BorderRadius.circular(100),
              ),
              child: Center(
                child: AppText(
                  text: '${widget.matchModel.maxScore}',
                  style: AppTextStyles.regular17,
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      return Obx(
        () => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(text: 'Rules', style: AppTextStyles.bold21),
                  Gap(8),
                  AppText(
                      text: 'Max score per playing time',
                      style: AppTextStyles.regular17),
                ],
              ),
              // Container(
              //   height: 55,
              //   width: 112,
              //   decoration: BoxDecoration(
              //     color: AppColors.purple,
              //     borderRadius: BorderRadius.circular(100),
              //   ),
              //   child: Center(
              //     child: AppText(
              //       text: _gameController.listOfRounds.isNotEmpty
              //           ? '${_gameController.listOfRounds.first.timeOfRound ~/ 60}:00'
              //           : '',
              //       style: AppTextStyles.regular17,
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      );
    }
  }

  Widget _history() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(text: 'History', style: AppTextStyles.bold21),
          //TODO
        ],
      ),
    );
  }

  String _getGameTypeName() {
    switch (widget.matchModel.gameType) {
      case 2:
        return 'Basketball';
      case 3:
        return 'Boxing';
      case 4:
        return 'Tennis';
      default:
        return 'Soccer';
    }
  }

  @override
  bool needScroll() {
    return false;
  }
}
