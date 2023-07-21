import 'package:android_freelance_2/controllers/game_controller/game_controller.dart';
import 'package:android_freelance_2/data/database/database_helper.dart';
import 'package:android_freelance_2/data/database/models/match_model.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final RxMap<String, GameController> listOfMatchesGameControllers =
      <String, GameController>{}.obs;
  final RxList<MatchModel> listOfActiveMatches = <MatchModel>[].obs;
  final RxList<MatchModel> listOfFinishedMatches = <MatchModel>[].obs;

  @override
  void onInit() {
    refreshAllData();
    super.onInit();
  }

  void refreshAllData() {
    refreshActiveMatches();
    refreshFinishedMatches();
  }

  void refreshActiveMatches() async {
    listOfActiveMatches.value =
        await DatabaseHelper.instance.getActiveMatches();
    for (final element in listOfActiveMatches) {
      listOfMatchesGameControllers.putIfAbsent(element.id.toString(), () {
        GameController gameController = GameController()..id = element.id ?? -1;
        return gameController;
      });
    }
  }

  void refreshFinishedMatches() async {
    listOfFinishedMatches.value =
        await DatabaseHelper.instance.getFinishedMatches();
    for (final element in listOfFinishedMatches) {
      listOfMatchesGameControllers.putIfAbsent(element.id.toString(), () {
        GameController gameController = GameController()..id = element.id ?? -1;
        return gameController;
      });
    }
  }
}
