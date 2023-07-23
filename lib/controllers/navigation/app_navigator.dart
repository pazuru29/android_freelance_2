import 'package:android_freelance_2/controllers/game_controller/game_controller.dart';
import 'package:android_freelance_2/data/database/models/match_model.dart';
import 'package:android_freelance_2/screens/create_new_game_screen/create_new_game_screen.dart';
import 'package:android_freelance_2/screens/edit_screen/edit_screen.dart';
import 'package:android_freelance_2/screens/game_screen/game_screen.dart';
import 'package:android_freelance_2/screens/home_screen/home_screen.dart';
import 'package:android_freelance_2/screens/on_boarding_screen/on_boarding_screen.dart';
import 'package:android_freelance_2/screens/privacy_policy_screen/privacy_policy_screen.dart';
import 'package:android_freelance_2/screens/settings_screen/settings_screen.dart';
import 'package:android_freelance_2/screens/terms_of_use_screen/terms_of_use_screen.dart';
import 'package:flutter/material.dart';

class AppNavigator {
  static void goBack(BuildContext context) {
    Navigator.pop(context);
  }

  static void replaceToOnBoardingScreen(BuildContext context) {
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => const OnBoardingScreen()));
  }

  static void replaceToHomeScreen(BuildContext context) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const HomeScreen()));
  }

  static void goToSettingsScreen(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const SettingsScreen()));
  }

  static void goToPrivacyPolicyScreen(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const PrivacyPolicyScreen()));
  }

  static void goToTermsOfUseScreen(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const TermsOfUseScreen()));
  }

  static void goToCreateNewGameScreen(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const CreateNewGameScreen()));
  }

  static void goToGameScreen(
      BuildContext context, GameController gameController, int id) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GameScreen(
          gameController: gameController,
          id: id,
        ),
      ),
    );
  }

  static void replaceToGameScreen(
      BuildContext context, GameController gameController, int id) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => GameScreen(
          gameController: gameController,
          id: id,
        ),
      ),
    );
  }

  static void replaceToEditScreen(
      BuildContext context, MatchModel matchModel, List<int> roundTime) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditScreen(
          matchModel: matchModel,
          roundTime: roundTime,
        ),
      ),
    );
  }
}
