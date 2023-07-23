import 'package:android_freelance_2/conmonents/drop_down_menu/models/app_drop_down_button_model.dart';
import 'package:android_freelance_2/controllers/game_controller/game_controller.dart';
import 'package:android_freelance_2/controllers/home_controller/home_controller.dart';
import 'package:android_freelance_2/controllers/navigation/app_navigator.dart';
import 'package:android_freelance_2/data/database/database_helper.dart';
import 'package:android_freelance_2/data/database/models/match_model.dart';
import 'package:android_freelance_2/data/database/models/round_model.dart';
import 'package:android_freelance_2/utils/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateNewGameController extends GetxController {
  final HomeController _homeController = Get.find();

  final RxInt _countOfRounds = 1.obs;

  int get countOfRounds => _countOfRounds.value;

  void changeCountOfRounds() => _countOfRounds.value++;

  final RxInt _rulesType = 0.obs;

  int get rulesType => _rulesType.value;

  void changeRulesType(int value) => _rulesType.value = value;

  List<AppDropDownButtonModel> listOfTypeGame = [
    AppDropDownButtonModel(
      title: 'Soccer',
      assetName: AppIcons.icSoccer,
      valueDatabase: 1,
    ),
    AppDropDownButtonModel(
      title: 'Basketball',
      assetName: AppIcons.icBasketball,
      valueDatabase: 2,
    ),
    AppDropDownButtonModel(
      title: 'Boxing',
      assetName: AppIcons.icBoxing,
      valueDatabase: 3,
    ),
    AppDropDownButtonModel(
      title: 'Tennis',
      assetName: AppIcons.icTennis,
      valueDatabase: 4,
    ),
  ];

  List<AppDropDownButtonModel> listOfTime = [
    AppDropDownButtonModel(title: '90:00', valueDatabase: 5400),
    AppDropDownButtonModel(title: '30:00', valueDatabase: 1800),
    AppDropDownButtonModel(title: '15:00', valueDatabase: 900),
  ];

  List<AppDropDownButtonModel> listOfScore = [
    AppDropDownButtonModel(title: '1'),
    AppDropDownButtonModel(title: '2'),
    AppDropDownButtonModel(title: '3'),
    AppDropDownButtonModel(title: '4'),
    AppDropDownButtonModel(title: '5'),
    AppDropDownButtonModel(title: '6'),
    AppDropDownButtonModel(title: '7'),
    AppDropDownButtonModel(title: '8'),
    AppDropDownButtonModel(title: '9'),
    AppDropDownButtonModel(title: '10'),
    AppDropDownButtonModel(title: '11'),
    AppDropDownButtonModel(title: '12'),
    AppDropDownButtonModel(title: '13'),
    AppDropDownButtonModel(title: '14'),
    AppDropDownButtonModel(title: '15'),
    AppDropDownButtonModel(title: '16'),
    AppDropDownButtonModel(title: '17'),
    AppDropDownButtonModel(title: '18'),
    AppDropDownButtonModel(title: '19'),
    AppDropDownButtonModel(title: '20'),
  ];

  final _currentGameType = Rxn<AppDropDownButtonModel>().obs;

  AppDropDownButtonModel? get currentGameType => _currentGameType.value.value;

  void changeCurrentGameType(AppDropDownButtonModel? value) =>
      _currentGameType.value.value = value;

  //1
  final Rx<AppDropDownButtonModel> _currentFirstRoundType =
      AppDropDownButtonModel(title: '').obs;

  AppDropDownButtonModel get currentFirstRoundType =>
      _currentFirstRoundType.value;

  void changeCurrentFirstRoundType(AppDropDownButtonModel value) =>
      _currentFirstRoundType.value = value;

  //2
  final Rx<AppDropDownButtonModel> _currentSecondRoundType =
      AppDropDownButtonModel(title: '').obs;

  AppDropDownButtonModel get currentSecondRoundType =>
      _currentSecondRoundType.value;

  void changeCurrentSecondRoundType(AppDropDownButtonModel value) =>
      _currentSecondRoundType.value = value;

  //3
  final Rx<AppDropDownButtonModel> _currentThirdRoundType =
      AppDropDownButtonModel(title: '').obs;

  AppDropDownButtonModel get currentThirdRoundType =>
      _currentThirdRoundType.value;

  void changeCurrentThirdRoundType(AppDropDownButtonModel value) =>
      _currentThirdRoundType.value = value;

  //4
  final Rx<AppDropDownButtonModel> _currentForthRoundType =
      AppDropDownButtonModel(title: '').obs;

  AppDropDownButtonModel get currentForthRoundType =>
      _currentForthRoundType.value;

  void changeCurrentForthRoundType(AppDropDownButtonModel value) =>
      _currentForthRoundType.value = value;

  final Rx<AppDropDownButtonModel> _currentScoreType =
      AppDropDownButtonModel(title: '').obs;

  AppDropDownButtonModel get currentScoreType => _currentScoreType.value;

  void changeCurrentScoreType(AppDropDownButtonModel value) =>
      _currentScoreType.value = value;

  @override
  void onInit() {
    _currentFirstRoundType.value = listOfTime.first;
    _currentSecondRoundType.value = listOfTime.first;
    _currentThirdRoundType.value = listOfTime.first;
    _currentForthRoundType.value = listOfTime.first;
    _currentScoreType.value = listOfScore.first;
    super.onInit();
  }

  void setInitEditData(MatchModel matchModel, List<int> roundTime) {
    if (matchModel.maxScore == null && roundTime.isNotEmpty) {
      _countOfRounds.value = roundTime.length;
      _currentFirstRoundType.value = listOfTime
          .firstWhere((element) => element.valueDatabase == roundTime.first);
    } else {
      _currentFirstRoundType.value = listOfTime.first;
    }

    if (roundTime.length > 1 &&
        matchModel.maxScore == null &&
        roundTime.isNotEmpty) {
      _currentSecondRoundType.value = listOfTime
          .firstWhere((element) => element.valueDatabase == roundTime[1]);
    } else {
      _currentSecondRoundType.value = listOfTime.first;
    }

    if (roundTime.length > 2 &&
        matchModel.maxScore == null &&
        roundTime.isNotEmpty) {
      _currentThirdRoundType.value = listOfTime
          .firstWhere((element) => element.valueDatabase == roundTime[2]);
    } else {
      _currentThirdRoundType.value = listOfTime.first;
    }

    if (roundTime.length > 3 &&
        matchModel.maxScore == null &&
        roundTime.isNotEmpty) {
      _currentForthRoundType.value = listOfTime
          .firstWhere((element) => element.valueDatabase == roundTime[3]);
    } else {
      _currentForthRoundType.value = listOfTime.first;
    }

    _rulesType.value = matchModel.maxScore == null ? 0 : 1;

    _currentScoreType.value = listOfScore.firstWhereOrNull(
            (element) => element.valueDatabase == matchModel.maxScore) ??
        listOfScore.first;

    _currentGameType.value.value = listOfTypeGame.firstWhereOrNull(
            (element) => element.valueDatabase == matchModel.gameType) ??
        listOfTypeGame.first;
  }

  void editMatch(BuildContext context, MatchModel matchModel, String? name,
      String nameTeam1, String nameTeam2) {
    DatabaseHelper.instance.deleteRounds(matchModel);
    GameController gameController = Get.find(tag: matchModel.id.toString());
    gameController.changeMatchModel(MatchModel(
      id: matchModel.id,
      name: name,
      nameTeam1: nameTeam1,
      nameTeam2: nameTeam2,
      scoreTeam1: 0,
      scoreTeam2: 0,
      timerType: 0,
      remainingTime: _rulesType.value == 0 ? 0 : null,
      currentRound: 1,
      gameType: _currentGameType.value.value?.valueDatabase ?? 0,
      maxScore: _rulesType.value == 1
          ? int.tryParse(_currentScoreType.value.title)
          : null,
    ));
    gameController.updateMatchModel();
    if (_rulesType.value == 0) {
      List<int> listForController = [];
      List<int> listOfTime = [];
      listOfTime.add(_currentFirstRoundType.value.valueDatabase ?? 0);
      listOfTime.add(_currentSecondRoundType.value.valueDatabase ?? 0);
      listOfTime.add(_currentThirdRoundType.value.valueDatabase ?? 0);
      listOfTime.add(_currentForthRoundType.value.valueDatabase ?? 0);
      for (var i = 0; i < _countOfRounds.value; i++) {
        listForController.add(listOfTime[i]);
        DatabaseHelper.instance.addRound(
          RoundModel(
            id: matchModel.id ?? -1,
            numberOfRound: i + 1,
            timeOfRound: listOfTime[i],
          ),
        );
      }
      gameController.roundsTime.value = listForController;
    }
    AppNavigator.goBack(context);
  }

  void saveMatch(
      BuildContext context, String? name, String nameTeam1, String nameTeam2) {
    DatabaseHelper.instance
        .addMatch(
      MatchModel(
        name: name,
        nameTeam1: nameTeam1,
        nameTeam2: nameTeam2,
        scoreTeam1: 0,
        scoreTeam2: 0,
        timerType: 0,
        remainingTime: _rulesType.value == 0 ? 0 : null,
        currentRound: 1,
        gameType: _currentGameType.value.value?.valueDatabase ?? 0,
        maxScore: _rulesType.value == 1
            ? int.tryParse(_currentScoreType.value.title)
            : null,
      ),
    )
        .then((value) {
      if (_rulesType.value == 0 && value != null) {
        List<int> listOfTime = [];
        listOfTime.add(_currentFirstRoundType.value.valueDatabase ?? 0);
        listOfTime.add(_currentSecondRoundType.value.valueDatabase ?? 0);
        listOfTime.add(_currentThirdRoundType.value.valueDatabase ?? 0);
        listOfTime.add(_currentForthRoundType.value.valueDatabase ?? 0);
        for (var i = 0; i < _countOfRounds.value; i++) {
          DatabaseHelper.instance.addRound(
            RoundModel(
              id: value,
              numberOfRound: i + 1,
              timeOfRound: listOfTime[i],
            ),
          );
        }
      }
      _homeController.refreshAllData().whenComplete(() {
        GameController gameController =
            Get.find<GameController>(tag: value.toString());
        AppNavigator.replaceToGameScreen(context, gameController, value ?? -1);
      });
    });
  }
}
