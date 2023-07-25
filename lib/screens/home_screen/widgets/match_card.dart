import 'dart:ui';

import 'package:android_freelance_2/conmonents/app_text.dart';
import 'package:android_freelance_2/controllers/game_controller/game_controller.dart';
import 'package:android_freelance_2/controllers/navigation/app_navigator.dart';
import 'package:android_freelance_2/utils/app_colors.dart';
import 'package:android_freelance_2/utils/app_icons.dart';
import 'package:android_freelance_2/utils/app_strings.dart';
import 'package:android_freelance_2/utils/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class MatchCard extends StatefulWidget {
  final GameController gameController;
  final int id;

  const MatchCard({
    required this.gameController,
    required this.id,
    super.key,
  });

  @override
  State<MatchCard> createState() => _MatchCardState();
}

class _MatchCardState extends State<MatchCard> {
  final double _bodyHeight = 120;

  late GameController _gameController;

  @override
  void initState() {
    _gameController =
        Get.find<GameController>(tag: widget.gameController.id.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: GestureDetector(
          onTap: () {
            AppNavigator.goToGameScreen(
                context, widget.gameController, widget.id);
          },
          child: Container(
            color: Colors.transparent,
            child: Column(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
                  decoration: const BoxDecoration(
                    color: AppColors.backgroundCard,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(_getGameTypeIcon()),
                          const Gap(7),
                          AppText(
                            text: _getGameTypeName(),
                            style: AppTextStyles.medium14,
                          ),
                        ],
                      ),
                      Flexible(
                        child: Row(
                          children: [
                            const Gap(8),
                            Flexible(
                              child: AppText(
                                text: widget.gameController.matchModel?.name ??
                                    AppStrings.myGame,
                                style: AppTextStyles.medium14,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 1,
                  color: AppColors.linePurple,
                ),
                Stack(
                  children: [
                    Container(
                      height: _bodyHeight,
                      decoration: const BoxDecoration(
                        color: AppColors.backgroundActivity,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                      ),
                      child: Row(
                        children: [
                          Flexible(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                _nameTeam(
                                    widget.gameController.matchModel
                                            ?.nameTeam1 ??
                                        '',
                                    widget.gameController.matchModel?.teamWin ==
                                        1),
                              ],
                            ),
                          ),
                          const Gap(25),
                          Container(
                            width: 1,
                            height: _bodyHeight,
                            color: AppColors.linePurple,
                          ),
                          const Gap(25),
                          Flexible(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                _nameTeam(
                                    widget.gameController.matchModel
                                            ?.nameTeam2 ??
                                        '',
                                    widget.gameController.matchModel?.teamWin ==
                                        2),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    _scoreWidget(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _scoreWidget() {
    if (widget.gameController.matchModel?.timerType == 3) {
      return Center(
        child: Container(
          height: 62,
          width: 80,
          margin: const EdgeInsets.only(top: 24),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: AppColors.lightPurple,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: AppColors.black.withOpacity(0.25),
                blurRadius: 10,
                offset: const Offset(2, 5),
              )
            ],
          ),
          child: FittedBox(
            child: AppText(
              text: '${_gameController.matchModel?.scoreTeam1} '
                  '- ${_gameController.matchModel?.scoreTeam2}',
              style: AppTextStyles.semiBold25,
              color: AppColors.darkPurpleText,
            ),
          ),
        ),
      );
    } else {
      return Center(
        child: Container(
          height: 62,
          width: 65,
          margin: const EdgeInsets.only(top: 24),
          padding: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
              color: AppColors.purple,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: AppColors.black.withOpacity(0.25),
                  blurRadius: 10,
                  offset: const Offset(2, 5),
                )
              ]),
          child: Center(
            child: FittedBox(
              child: AppText(
                text: _gameController.isRoundMatch == false
                    ? '${_gameController.matchModel?.scoreTeam1} - ${_gameController.matchModel?.scoreTeam2}'
                    : _gameController.isRoundMatch == true &&
                            _gameController.matchModel?.timerType != 0 &&
                            _gameController.matchModel?.timerType != 3 &&
                            _gameController.roundsTime.isNotEmpty
                        ? '${((_gameController.currentRoundTime - _gameController.currentTime.toInt()) ~/ 60).toString().padLeft(2, '0')}:${((_gameController.currentRoundTime - _gameController.currentTime.toInt()) % 60).toString().padLeft(2, '0')}'
                        : 'VS',
                style: AppTextStyles.semiBold25,
              ),
            ),
          ),
        ),
      );
    }
  }

  Widget _nameTeam(String title, bool isWin) {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(35, 17, 35, 21),
        child: Column(
          children: [
            Container(
              height: 30,
              width: 30,
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: isWin ? AppColors.green : AppColors.lightPurple,
                borderRadius: BorderRadius.circular(100),
              ),
              child: SvgPicture.asset(
                _getGameTypeIcon(),
                color: isWin ? AppColors.darkPurpleText : AppColors.white,
              ),
            ),
            const Spacer(),
            AppText(
              text: title,
              style: AppTextStyles.regular16,
              maxLines: 2,
              align: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              color: isWin ? AppColors.green : AppColors.white,
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  String _getGameTypeName() {
    switch (widget.gameController.matchModel?.gameType) {
      case 2:
        return AppStrings.basketball;
      case 3:
        return AppStrings.boxing;
      case 4:
        return AppStrings.tennis;
      default:
        return AppStrings.soccer;
    }
  }

  String _getGameTypeIcon() {
    switch (widget.gameController.matchModel?.gameType) {
      case 2:
        return AppIcons.icBasketball;
      case 3:
        return AppIcons.icBoxing;
      case 4:
        return AppIcons.icTennis;
      default:
        return AppIcons.icSoccer;
    }
  }
}
