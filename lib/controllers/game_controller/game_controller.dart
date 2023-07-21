import 'dart:async';

import 'package:android_freelance_2/controllers/home_controller/home_controller.dart';
import 'package:android_freelance_2/data/database/database_helper.dart';
import 'package:android_freelance_2/data/database/models/match_model.dart';
import 'package:android_freelance_2/utils/extansions/app_date.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GameController extends GetxController {
  late final int id;

  final RxBool _isRoundMatch = true.obs;

  bool get isRoundMatch => _isRoundMatch.value;

  late bool isFinished;

  final HomeController _homeController = Get.find();

  final _matchModel = Rxn<MatchModel>().obs;

  MatchModel? get matchModel => _matchModel.value.value;

  void changeMatchModel(MatchModel? matchModel) =>
      _matchModel.value.value = matchModel;

  void setRemainingTime() {
    _matchModel.value.value?.remainingTime = _currentTime.value;
    updateMatchModel();
  }

  RxList<int> roundsTime = <int>[].obs;

  void onScorePlusPressed(bool isTeam1) {
    if (isTeam1) {
      if (isRoundMatch && matchModel?.timerType == 1) {
        _matchModel.value.value?.scoreTeam1 += 1;
        updateMatchModel();
        checkOnFinishGame();
      } else if (!isRoundMatch) {
        _matchModel.value.value?.scoreTeam1 += 1;
        updateMatchModel();
        checkOnFinishGame();
      }
    } else {
      if (isRoundMatch && matchModel?.timerType == 1) {
        _matchModel.value.value?.scoreTeam2 += 1;
        updateMatchModel();
        checkOnFinishGame();
      } else if (!isRoundMatch) {
        _matchModel.value.value?.scoreTeam2 += 1;
        updateMatchModel();
        checkOnFinishGame();
      }
    }
  }

  void onScoreMinusPressed(bool isTeam1) {
    if (isTeam1) {
      if (isRoundMatch &&
          matchModel?.timerType == 1 &&
          matchModel!.scoreTeam1 > 0) {
        _matchModel.value.value?.scoreTeam1 -= 1;
        updateMatchModel();
      } else if (!isRoundMatch && matchModel!.scoreTeam1 > 0) {
        _matchModel.value.value?.scoreTeam1 -= 1;
        updateMatchModel();
      }
    } else {
      if (isRoundMatch &&
          matchModel?.timerType == 1 &&
          matchModel!.scoreTeam2 > 0) {
        _matchModel.value.value?.scoreTeam2 -= 1;
        updateMatchModel();
      } else if (!isRoundMatch && matchModel!.scoreTeam2 > 0) {
        _matchModel.value.value?.scoreTeam2 -= 1;
        updateMatchModel();
      }
    }
  }

  void checkOnFinishGame() {
    if (matchModel?.scoreTeam1 == matchModel?.maxScore ||
        matchModel?.scoreTeam2 == matchModel?.maxScore) {
      _matchModel.value.value?.timerType = 3;
      _matchModel.value.value?.teamWin =
          matchModel!.scoreTeam1 > matchModel!.scoreTeam2 ? 1 : 2;
      updateMatchModel();
      _homeController.refreshAllData();
    }
  }

  // Timer time
  final RxDouble _currentTime = 0.0.obs;

  double get currentTime => _currentTime.value;

  int _currentRoundTime = 0;

  void setCurrentTime(double currentTime) => _currentTime.value = currentTime;

  late Timer _timer;

  void startTimer() {
    _matchModel.value.value?.timerType = 1;
    updateMatchModel();
    changeMatchModel(_matchModel.value.value);
    _currentRoundTime = roundsTime[_matchModel.value.value!.currentRound! - 1];
    _timer = Timer.periodic(
      const Duration(milliseconds: 25),
      (timer) {
        _currentTime.value += 0.025;
        print(_currentTime.value);
        if (_currentTime >= _currentRoundTime) {
          timer.cancel();
          if (_matchModel.value.value!.currentRound! < roundsTime.length) {
            _currentRoundTime =
                roundsTime[_matchModel.value.value!.currentRound!];
            _matchModel.value.value?.timerType = 2;
            _matchModel.value.value?.currentRound =
                _matchModel.value.value!.currentRound! + 1;
            updateMatchModel();
          } else {
            _matchModel.value.value?.timerType = 3;
            _matchModel.value.value?.teamWin =
                matchModel!.scoreTeam1 > matchModel!.scoreTeam2
                    ? 1
                    : matchModel!.scoreTeam2 > matchModel!.scoreTeam1
                        ? 2
                        : 0;
            updateMatchModel();
            _homeController.refreshAllData();
          }
          _currentTime.value = 0;
        }
      },
    );
  }

  void pauseTimer() {
    _matchModel.value.value?.timerType = 2;
    updateMatchModel();
    changeMatchModel(_matchModel.value.value);
    _timer.cancel();
  }

  @override
  void onInit() {
    refreshMatchModel().whenComplete(() {
      checkTimeAfterCloseApp();
      _currentTime.value = matchModel?.remainingTime?.toDouble() ?? 0;
    });
    super.onInit();
  }

  Future refreshMatchModel() async {
    await DatabaseHelper.instance.getActiveMatchesById(id).then((value) async {
      _matchModel.value.value = value;
      _isRoundMatch.value = value.maxScore == null;
      isFinished = value.timerType == 3;
      if (value.maxScore == null) {
        var listOfRounds = await DatabaseHelper.instance.getRoundsById(id);
        roundsTime.value = [];
        for (final element in listOfRounds) {
          roundsTime.add(element.timeOfRound);
        }
      }
    });
  }

  void updateMatchModel() async {
    await DatabaseHelper.instance
        .updateMatchById(_matchModel.value.value!)
        .whenComplete(() => refreshMatchModel());
  }

  void checkTimeAfterCloseApp() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    double? remainingTime = prefs.getDouble('$id');
    String? resumedTime = prefs.getString('${id}_dateTime');
    if (remainingTime != null && resumedTime != null) {
      DateTime time = AppDate.fromDataBaseFormatter(resumedTime);
      setCurrentTime(remainingTime +
          (DateTime.now().difference(time).inMilliseconds / 1000));
      startTimer();
      prefs.remove('$id');
      prefs.remove('${id}_dateTime');
    }
  }
}
