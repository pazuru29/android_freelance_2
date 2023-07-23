import 'package:android_freelance_2/controllers/game_controller/game_controller.dart';
import 'package:android_freelance_2/data/database/database_helper.dart';
import 'package:android_freelance_2/data/database/models/match_model.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  RxMap<String, GameController> listOfMatchesGameControllers =
      <String, GameController>{}.obs;
  final RxList<MatchModel> listOfActiveMatches = <MatchModel>[].obs;
  final RxList<MatchModel> listOfFinishedMatches = <MatchModel>[].obs;

  @override
  void onInit() {
    refreshAllData();
    super.onInit();
  }

  Future refreshAllData() async {
    Get.deleteAll();
    await refreshActiveMatches();
    await refreshFinishedMatches();
  }

  Future refreshActiveMatches() async {
    listOfActiveMatches.value =
        await DatabaseHelper.instance.getActiveMatches();
    for (final element in listOfActiveMatches) {
      GameController gameController = GameController()..id = element.id ?? -1;
      listOfMatchesGameControllers[element.id.toString()] = gameController;
      Get.put<GameController>(gameController, tag: element.id.toString());
    }
  }

  Future refreshFinishedMatches() async {
    listOfFinishedMatches.value =
        await DatabaseHelper.instance.getFinishedMatches();
    for (final element in listOfFinishedMatches) {
      GameController gameController = GameController()..id = element.id ?? -1;
      listOfMatchesGameControllers[element.id.toString()] = gameController;
      Get.put<GameController>(gameController, tag: element.id.toString());
    }
  }
}
