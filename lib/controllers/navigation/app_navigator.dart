import 'package:android_freelance_2/controllers/game_controller/game_controller.dart';
import 'package:android_freelance_2/data/database/models/match_model.dart';
import 'package:android_freelance_2/screens/create_new_game_screen/create_new_game_screen.dart';
import 'package:android_freelance_2/screens/game_screen/game_screen.dart';
import 'package:android_freelance_2/screens/home_screen/home_screen.dart';
import 'package:android_freelance_2/screens/on_boarding_screen/on_boarding_screen.dart';
import 'package:android_freelance_2/screens/privacy_policy_screen/privacy_policy_screen.dart';
import 'package:android_freelance_2/screens/settings_screen/settings_screen.dart';
import 'package:android_freelance_2/screens/terms_of_use_screen/terms_of_use_screen.dart';
import 'package:get/get.dart';

class AppNavigator {
  static void goBack() {
    Get.back();
  }

  static void replaceToOnBoardingScreen() {
    Get.off(() => const OnBoardingScreen());
  }

  static void replaceToHomeScreen() {
    Get.off(() => const HomeScreen());
  }

  static void goToSettingsScreen() {
    Get.to(() => const SettingsScreen());
  }

  static void goToPrivacyPolicyScreen() {
    Get.to(() => const PrivacyPolicyScreen());
  }

  static void goToTermsOfUseScreen() {
    Get.to(() => const TermsOfUseScreen());
  }

  static void goToCreateNewGameScreen() {
    Get.to(() => const CreateNewGameScreen());
  }

  static void goToGameScreen(GameController gameController) {
    Get.to(
      () => GameScreen(
        gameController: gameController,
      ),
    );
  }
}
