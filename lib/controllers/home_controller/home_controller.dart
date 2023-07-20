import 'package:android_freelance_2/data/database/database_helper.dart';
import 'package:android_freelance_2/data/database/models/match_model.dart';
import 'package:android_freelance_2/data/database/models/round_model.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final RxList<MatchModel> listOfActiveMatches = <MatchModel>[].obs;
  final RxList<MatchModel> listOfFinishedMatches = <MatchModel>[].obs;

  @override
  void onInit() {
    refreshActiveMatches();
    super.onInit();
  }

  void refreshActiveMatches() async {
    listOfActiveMatches.value =
        await DatabaseHelper.instance.getActiveMatches();
  }

  void refreshFinishedMatches() async {
    listOfActiveMatches.value =
        await DatabaseHelper.instance.getActiveMatches();
  }
}
