class MatchModel {
  int? id;
  String? name;
  String nameTeam1;
  String nameTeam2;
  int scoreTeam1;
  int scoreTeam2;
  int isFinished;
  int? teamWin;
  int gameType;
  int? maxScore;

  MatchModel({
    this.id,
    this.name,
    required this.nameTeam1,
    required this.nameTeam2,
    required this.scoreTeam1,
    required this.scoreTeam2,
    required this.isFinished,
    required this.gameType,
    this.teamWin,
    this.maxScore,
  });

  factory MatchModel.fromMap(Map<String, dynamic> json) => MatchModel(
        id: json['id'],
        name: json['name'],
        nameTeam1: json['name_team_1'] ?? '',
        nameTeam2: json['name_team_2'] ?? '',
        scoreTeam1: json['score_team_1'],
        scoreTeam2: json['score_team_2'],
        isFinished: json['is_finished'],
        teamWin: json['team_win'],
        gameType: json['game_type'],
        maxScore: json['max_score'],
      );

  Map<String, dynamic> toMap() {
    var map = <String, Object?>{
      'name': name,
      'name_team_1': nameTeam1,
      'name_team_2': nameTeam2,
      'score_team_1': scoreTeam1,
      'score_team_2': scoreTeam2,
      'is_finished': isFinished,
      'team_win': teamWin,
      'game_type': gameType,
      'max_score': maxScore,
    };

    if (id != null) {
      map['id'] = id;
    }
    return map;
  }
}
