import 'package:android_freelance_2/conmonents/app_text.dart';
import 'package:android_freelance_2/controllers/navigation/app_navigator.dart';
import 'package:android_freelance_2/data/database/models/match_model.dart';
import 'package:android_freelance_2/utils/app_colors.dart';
import 'package:android_freelance_2/utils/app_icons.dart';
import 'package:android_freelance_2/utils/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class MatchCard extends StatefulWidget {
  final MatchModel matchModel;

  const MatchCard({
    required this.matchModel,
    super.key,
  });

  @override
  State<MatchCard> createState() => _MatchCardState();
}

class _MatchCardState extends State<MatchCard> {
  final double _bodyHeight = 120;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: GestureDetector(
        onTap: () {
          AppNavigator.goToGameScreen(widget.matchModel);
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
                    AppText(
                      text: widget.matchModel.name ?? 'My game',
                      style: AppTextStyles.medium14,
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
                              _nameTeam(widget.matchModel.nameTeam1,
                                  widget.matchModel.teamWin == 1),
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
                              _nameTeam(widget.matchModel.nameTeam2,
                                  widget.matchModel.teamWin == 2),
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
    );
  }

  Widget _scoreWidget() {
    if (widget.matchModel.isFinished == 1) {
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
          child: const FittedBox(
            child: AppText(
              text: '3 - 1',
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
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
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
          child: const FittedBox(
            child: AppText(
              text: 'VS',
              style: AppTextStyles.semiBold25,
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
                AppIcons.icSoccer,
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

  String _getGameTypeIcon() {
    switch (widget.matchModel.gameType) {
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