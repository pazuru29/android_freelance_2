class HistoryModel {
  int? id;
  int matchId;
  String nameOfTeam;
  String time;

  HistoryModel({
    this.id,
    required this.matchId,
    required this.nameOfTeam,
    required this.time,
  });

  factory HistoryModel.fromMap(Map<String, dynamic> json) => HistoryModel(
        id: json['id'],
        matchId: json['match_id'],
        nameOfTeam: json['name_of_team'],
        time: json['time'],
      );

  Map<String, dynamic> toMap() {
    var map = <String, Object?>{
      'match_id': matchId,
      'name_of_team': nameOfTeam,
      'time': time,
    };

    if (id != null) {
      map['id'] = id;
    }

    return map;
  }
}
