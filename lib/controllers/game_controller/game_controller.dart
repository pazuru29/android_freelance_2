import 'dart:async';

import 'package:android_freelance_2/controllers/home_controller/home_controller.dart';
import 'package:android_freelance_2/controllers/navigation/app_navigator.dart';
import 'package:android_freelance_2/data/database/database_helper.dart';
import 'package:android_freelance_2/data/database/models/history_model.dart';
import 'package:android_freelance_2/data/database/models/match_model.dart';
import 'package:android_freelance_2/data/database/models/round_model.dart';
import 'package:android_freelance_2/utils/extansions/app_date.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GameController extends GetxController {
  late final int id;

  final RxBool _isRoundMatch = true.obs;

  bool get isRoundMatch => _isRoundMatch.value;

  bool isFinished = false;

  final HomeController _homeController = Get.find();

  final _matchModel = Rxn<MatchModel>().obs;

  MatchModel? get matchModel => _matchModel.value.value;

  void changeMatchModel(MatchModel matchModel) =>
      _matchModel.value.value = matchModel;

  final RxList<HistoryModel> listOfHistory = <HistoryModel>[].obs;

  RxList<int> roundsTime = <int>[].obs;

  //Work with score
  void onScorePlusPressed(bool isTeam1) {
    if (isTeam1) {
      if (isRoundMatch && matchModel?.timerType == 1) {
        _matchModel.value.value?.scoreTeam1 += 1;
        _matchModel.value.value?.remainingTime = _currentTime.value;
        updateMatchModel();
        addHistory(matchModel?.nameTeam1 ?? '');
      } else if (!isRoundMatch) {
        _matchModel.value.value?.scoreTeam1 += 1;
        updateMatchModel();
        checkOnFinishScoreGame();
      }
    } else {
      if (isRoundMatch && matchModel?.timerType == 1) {
        _matchModel.value.value?.scoreTeam2 += 1;
        _matchModel.value.value?.remainingTime = _currentTime.value;
        updateMatchModel();
        addHistory(matchModel?.nameTeam2 ?? '');
      } else if (!isRoundMatch) {
        _matchModel.value.value?.scoreTeam2 += 1;
        updateMatchModel();
        checkOnFinishScoreGame();
      }
    }
  }

  void onScoreMinusPressed(bool isTeam1) {
    if (isTeam1) {
      if (isRoundMatch &&
          matchModel?.timerType == 1 &&
          matchModel!.scoreTeam1 > 0) {
        _matchModel.value.value?.scoreTeam1 -= 1;
        _matchModel.value.value?.remainingTime = _currentTime.value;
        updateMatchModel();
        deleteOneHistory(listOfHistory.firstWhere(
            (element) => element.nameOfTeam == matchModel?.nameTeam1));
      } else if (!isRoundMatch && matchModel!.scoreTeam1 > 0) {
        _matchModel.value.value?.scoreTeam1 -= 1;
        updateMatchModel();
      }
    } else {
      if (isRoundMatch &&
          matchModel?.timerType == 1 &&
          matchModel!.scoreTeam2 > 0) {
        _matchModel.value.value?.scoreTeam2 -= 1;
        _matchModel.value.value?.remainingTime = _currentTime.value;
        updateMatchModel();
        deleteOneHistory(listOfHistory.firstWhere(
            (element) => element.nameOfTeam == matchModel?.nameTeam2));
      } else if (!isRoundMatch && matchModel!.scoreTeam2 > 0) {
        _matchModel.value.value?.scoreTeam2 -= 1;
        updateMatchModel();
      }
    }
  }

  void checkOnFinishScoreGame() {
    if (matchModel?.scoreTeam1 == matchModel?.maxScore ||
        matchModel?.scoreTeam2 == matchModel?.maxScore) {
      _matchModel.value.value?.timerType = 3;
      _matchModel.value.value?.teamWin =
          matchModel!.scoreTeam1 > matchModel!.scoreTeam2 ? 1 : 2;
      updateMatchModel();
      refreshAllDataHomeController();
    }
  }

  // Work with timer
  final RxDouble _currentTime = 0.0.obs;

  double get currentTime => _currentTime.value;

  final RxInt _currentRoundTime = 0.obs;

  int get currentRoundTime => _currentRoundTime.value;

  void setCurrentTime(double currentTime) => _currentTime.value = currentTime;

  late Timer _timer;

  bool isTimerActive = false;

  void startTimer() {
    _matchModel.value.value?.timerType = 1;
    _matchModel.value.value?.remainingTime = _currentTime.value;
    updateMatchModel();
    isTimerActive = true;
    _timer = Timer.periodic(
      const Duration(milliseconds: 25),
      (timer) {
        _currentTime.value += 0.025;
        print(_currentTime.value);
        if (_currentTime >= _currentRoundTime.value) {
          timer.cancel();
          if (_matchModel.value.value!.currentRound! < roundsTime.length) {
            _currentRoundTime.value =
                roundsTime[_matchModel.value.value!.currentRound!];
            _matchModel.value.value?.timerType = 2;
            _matchModel.value.value?.currentRound =
                _matchModel.value.value!.currentRound! + 1;
            _matchModel.value.value?.remainingTime = null;
            updateMatchModel();
          } else {
            _matchModel.value.value?.timerType = 3;
            _matchModel.value.value?.teamWin =
                matchModel!.scoreTeam1 > matchModel!.scoreTeam2
                    ? 1
                    : matchModel!.scoreTeam2 > matchModel!.scoreTeam1
                        ? 2
                        : 0;
            _matchModel.value.value?.remainingTime = null;
            updateMatchModel();
            refreshAllDataHomeController();
          }
          _currentTime.value = 0;
        }
      },
    );
  }

  void pauseTimer() {
    isTimerActive = false;
    _timer.cancel();
    _matchModel.value.value?.remainingTime = _currentTime.value;
    _matchModel.value.value?.timerType = 2;
    updateMatchModel();
  }

  //Game controller lifecycle
  @override
  void onInit() {
    takeMatchModel().whenComplete(() async {
      _isRoundMatch.value = matchModel?.maxScore == null;

      checkTimeAfterCloseApp();
    });
    super.onInit();
  }

  @override
  InternalFinalCallback<void> get onDelete {
    onDetached();
    return super.onDelete;
  }

  void onDetached() async {
    _matchModel.value.value?.remainingDate =
        AppDate.dataBaseFormatter(DateTime.now());
    if (matchModel?.timerType == 1) {
      print('TIMER CANCEL');
      _timer.cancel();
      isTimerActive = false;
    }
    _matchModel.value.value?.remainingTime = _currentTime.value;
    saveMatchModel();
  }

  void checkTimeAfterCloseApp() async {
    if (matchModel?.remainingDate != null &&
        matchModel?.timerType == 1 &&
        !isTimerActive) {
      DateTime time = AppDate.fromDataBaseFormatter(matchModel!.remainingDate!);
      _currentTime.value = matchModel!.remainingTime! +
          (DateTime.now().difference(time).inMilliseconds / 1000);
      startTimer();
    } else {
      _currentTime.value = matchModel?.remainingTime?.toDouble() ?? 0;
    }
  }

  //Work with match
  Future takeMatchModel() async {
    await DatabaseHelper.instance.getActiveMatchesById(id).then((value) async {
      if (value != null) {
        _matchModel.value.value = value;
        isFinished = value.timerType == 3;
        if (matchModel?.maxScore == null) {
          var listOfRounds = await DatabaseHelper.instance.getRoundsById(id);
          List<int> list = [];
          for (final element in listOfRounds) {
            list.add(element.timeOfRound);
          }
          roundsTime.value = list;
          getHistory();
        }
        _currentRoundTime.value = roundsTime.isNotEmpty
            ? roundsTime[matchModel!.currentRound! - 1]
            : 0;
        _currentTime.value = value.remainingTime?.toDouble() ?? 0;
      }
    });
  }

  void saveMatchModel() async {
    if (_matchModel.value.value != null) {
      await DatabaseHelper.instance.updateMatchById(_matchModel.value.value!);
      print('DATA SAVE');
    }
  }

  void updateMatchModel() async {
    if (_matchModel.value.value != null) {
      await DatabaseHelper.instance
          .updateMatchById(_matchModel.value.value!)
          .whenComplete(() => takeMatchModel());
      print('DATA UPDATE');
    }
  }

  void refreshAllDataHomeController() {
    _homeController.refreshAllData();
  }

  void deleteMatch(BuildContext context) {
    if (matchModel?.maxScore == null) {
      DatabaseHelper.instance.deleteRounds(matchModel!);
      DatabaseHelper.instance.deleteHistory(matchModel!);
    }
    DatabaseHelper.instance.deleteMatchById(matchModel!);
    _homeController.listOfMatchesGameControllers.remove(id.toString());
    Get.delete<GameController>(tag: id.toString());
    AppNavigator.goBack(context);
    refreshAllDataHomeController();
  }

  //Work with history of match
  void getHistory() async {
    listOfHistory.value = await DatabaseHelper.instance.getHistoryById(id);
  }

  void deleteOneHistory(HistoryModel historyModel) {
    DatabaseHelper.instance
        .deleteOneHistory(historyModel)
        .whenComplete(() => getHistory());
  }

  void addHistory(String nameOfTeam) {
    DatabaseHelper.instance
        .addHistory(
          HistoryModel(
            matchId: id,
            nameOfTeam: nameOfTeam,
            time:
                '${((currentTime.toInt()) ~/ 60).toString().padLeft(2, '0')}:${((currentTime.toInt()) % 60).toString().padLeft(2, '0')}',
          ),
        )
        .whenComplete(() => getHistory());
  }

  //Duplicate match
  void duplicateMatch(BuildContext context) async {
    await DatabaseHelper.instance
        .addMatch(MatchModel(
      name: matchModel?.name,
      nameTeam1: matchModel?.nameTeam1 ?? '',
      nameTeam2: matchModel?.nameTeam2 ?? '',
      scoreTeam1: 0,
      scoreTeam2: 0,
      timerType: 0,
      gameType: matchModel?.gameType ?? 0,
      maxScore: matchModel?.maxScore,
      currentRound: 1,
    ))
        .then((value) {
      if (matchModel?.maxScore == null) {
        var iterator = 1;
        for (final element in roundsTime) {
          DatabaseHelper.instance.addRound(
            RoundModel(
              id: value ?? -1,
              numberOfRound: iterator,
              timeOfRound: element,
            ),
          );
          iterator++;
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
