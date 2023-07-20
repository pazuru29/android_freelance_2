abstract class GameController {
  final int matchId;
  int teamScore1;
  int teamScore2;

  GameController({
    required this.matchId,
    required this.teamScore1,
    required this.teamScore2,
  });
}

class MatchRoundsController extends GameController {
  List<int> roundsTime;

  MatchRoundsController({
    required super.matchId,
    required super.teamScore1,
    required super.teamScore2,
    required this.roundsTime,
  });


}

class MatchScoreController extends GameController {
  MatchScoreController({
    required super.matchId,
    required super.teamScore1,
    required super.teamScore2,
  });
}
