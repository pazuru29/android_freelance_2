import 'dart:async';

import 'package:android_freelance_2/conmonents/app_button.dart';
import 'package:android_freelance_2/conmonents/app_rounded_icon_button.dart';
import 'package:android_freelance_2/conmonents/app_text.dart';
import 'package:android_freelance_2/conmonents/base_screen.dart';
import 'package:android_freelance_2/conmonents/secondary_app_bar.dart';
import 'package:android_freelance_2/controllers/game_controller/game_controller.dart';
import 'package:android_freelance_2/utils/app_colors.dart';
import 'package:android_freelance_2/utils/app_icons.dart';
import 'package:android_freelance_2/utils/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class GameScreen extends BaseScreen {
  final GameController gameController;

  const GameScreen({
    required this.gameController,
    super.key,
  });

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends BaseScreenState<GameScreen> {
  late GameController _gameController;

  @override
  void initState() {
    _gameController = Get.find(tag: widget.gameController.id.toString());
    super.initState();
  }

  @override
  Widget buildMain(BuildContext context) {
    return SafeArea(
      child: Obx(
        () => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SecondaryAppBar(
              title: _getGameTypeName(),
              titleBack: 'Back to matches',
              subtitle: _gameController.isRoundMatch
                  ? '${_gameController.matchModel?.currentRound}'
                  : widget.gameController.matchModel?.name ?? 'My game',
              child: GestureDetector(
                onTap: () {},
                child: SvgPicture.asset(AppIcons.icMore),
              ),
            ),
            _scoreWidget(),
            const Gap(45),
            _rulesWidget(),
            if (widget.gameController.matchModel?.maxScore == null)
              Padding(
                padding: const EdgeInsets.fromLTRB(25, 35, 25, 45),
                child: AppButton(
                  title: widget.gameController.matchModel?.timerType == 0 ||
                          widget.gameController.matchModel?.timerType == 2
                      ? 'Start Game'
                      : widget.gameController.matchModel?.timerType == 3
                          ? 'Dublicate game'
                          : 'Pause',
                  bgColor: widget.gameController.matchModel?.timerType == 0 ||
                          widget.gameController.matchModel?.timerType == 2
                      ? AppColors.green
                      : widget.gameController.matchModel?.timerType == 3
                          ? AppColors.lightPurple
                          : AppColors.red,
                  onPressed: () {
                    if (widget.gameController.matchModel?.timerType == 0 ||
                        widget.gameController.matchModel?.timerType == 2) {
                      _gameController.startTimer();
                    } else if (widget.gameController.matchModel?.timerType ==
                        1) {
                      _gameController.pauseTimer();
                    }
                  },
                ),
              ),
            if (widget.gameController.matchModel?.maxScore == null) _history(),
          ],
        ),
      ),
    );
  }

  Widget _scoreWidget() {
    return Obx(
      () => Padding(
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
            _teamScore(1, widget.gameController.matchModel?.nameTeam1 ?? '',
                widget.gameController.matchModel?.scoreTeam1 ?? 0, true),
            const Gap(10),
            _teamScore(2, widget.gameController.matchModel?.nameTeam2 ?? '',
                widget.gameController.matchModel?.scoreTeam2 ?? 0, false),
          ],
        ),
      ),
    );
  }

  Widget _teamScore(
      int numberOfTeam, String nameOfTeam, int scoreOfTeam, bool isTeam1) {
    return Row(
      children: [
        Container(
          height: 55,
          width: 38,
          decoration: BoxDecoration(
            color: (isTeam1 && _gameController.matchModel?.teamWin == 1) ||
                    (!isTeam1 && _gameController.matchModel?.teamWin == 2)
                ? AppColors.green
                : AppColors.purple,
            borderRadius: BorderRadius.circular(100),
          ),
          child: Center(
            child: AppText(
              text: '$numberOfTeam',
              style: AppTextStyles.regular30,
              color: (isTeam1 && _gameController.matchModel?.teamWin == 1) ||
                      (!isTeam1 && _gameController.matchModel?.teamWin == 2)
                  ? AppColors.darkPurpleText
                  : AppColors.white,
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
                color: (isTeam1 && _gameController.matchModel?.teamWin == 1) ||
                        (!isTeam1 && _gameController.matchModel?.teamWin == 2)
                    ? AppColors.green
                    : AppColors.purple,
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
                    if (!_gameController.isFinished)
                      AppRoundedIconButton(
                        assetName: AppIcons.icMinus,
                        onPressed: () {
                          _gameController.onScoreMinusPressed(isTeam1);
                        },
                      ),
                    if (!_gameController.isFinished) const Gap(2),
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
                    if (!_gameController.isFinished) const Gap(2),
                    if (!_gameController.isFinished)
                      AppRoundedIconButton(
                        assetName: AppIcons.icPlus,
                        onPressed: () {
                          _gameController.onScorePlusPressed(isTeam1);
                        },
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
    if (widget.gameController.matchModel?.maxScore != null) {
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
                  text: '${_gameController.matchModel?.maxScore}',
                  style: AppTextStyles.regular17,
                ),
              ),
            ),
          ],
        ),
      );
    } else {
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
                AppText(
                    text: 'Max score per playing time',
                    style: AppTextStyles.regular17),
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
                  text:
                      '${((_gameController.roundsTime.first - _gameController.currentTime.toInt()) ~/ 60).toString().padLeft(2, '0')}:${((_gameController.roundsTime.first - _gameController.currentTime.toInt()) % 60).toString().padLeft(2, '0')}',
                  style: AppTextStyles.regular17,
                ),
              ),
            ),
          ],
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
          Gap(10),
          AppText(
            text: 'Nothing happened yet',
            style: AppTextStyles.regular19,
            color: AppColors.lightPurple,
          )
        ],
      ),
    );
  }

  String _getGameTypeName() {
    switch (widget.gameController.matchModel?.gameType) {
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
