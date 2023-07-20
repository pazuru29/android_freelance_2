class RoundModel {
  int id;
  int numberOfRound;
  int timeOfRound;

  RoundModel({
    required this.id,
    required this.numberOfRound,
    required this.timeOfRound,
  });

  factory RoundModel.fromMap(Map<String, dynamic> json) => RoundModel(
        id: json['id'],
        numberOfRound: json['number_of_round'],
        timeOfRound: json['time_of_round'],
      );

  Map<String, dynamic> toMap() {
    var map = <String, Object?>{
      'id': id,
      'number_of_round': numberOfRound,
      'time_of_round': timeOfRound,
    };

    return map;
  }
}
