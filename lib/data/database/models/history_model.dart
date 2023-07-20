class HistoryModel {
  int id;
  String nameOfTeam;
  String time;

  HistoryModel({
    required this.id,
    required this.nameOfTeam,
    required this.time,
  });

  factory HistoryModel.fromMap(Map<String, dynamic> json) => HistoryModel(
        id: json['id'],
        nameOfTeam: json['name_of_team'],
        time: json['time'],
      );

  Map<String, dynamic> toMap() {
    var map = <String, Object?>{
      'id': id,
      'name_of_team': nameOfTeam,
      'time': time,
    };

    return map;
  }
}
