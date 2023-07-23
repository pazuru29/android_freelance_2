import 'dart:io';

import 'package:android_freelance_2/data/database/models/history_model.dart';
import 'package:android_freelance_2/data/database/models/match_model.dart';
import 'package:android_freelance_2/data/database/models/round_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  DatabaseHelper._instance();

  static final DatabaseHelper instance = DatabaseHelper._instance();

  static Database? _database;

  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'sport_matches.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''CREATE TABLE matches (
    id INTEGER PRIMARY KEY,
    name	TEXT,
    name_team_1 TEXT NOT NULL,
    name_team_2 TEXT NOT NULL,
    score_team_1 INTEGER NOT NULL,
    score_team_2 INTEGER NOT NULL,
    timer_type INTEGER NOT NULL,
    team_win INTEGER,
    game_type INTEGER NOT NULL,
    max_score INTEGER,
    remaining_time REAL,
    remaining_date TEXT,
    current_round INTEGER
    )''');

    await db.execute('''CREATE TABLE rounds (
    id INTEGER NOT NULL,
    number_of_round INTEGER NOT NULL,
    time_of_round INTEGER NOT NULL
    )''');

    await db.execute('''CREATE TABLE history (
    id INTEGER PRIMARY KEY,
    match_id INTEGER NOT NULL,
    name_of_team TEXT NOT NULL,
    time TEXT NOT NULL
    )''');
  }

  Future<List<MatchModel>> getActiveMatches() async {
    Database db = await instance.database;
    var matches = await db.query('matches');
    return matches
        .map((e) => MatchModel.fromMap(e))
        .toList()
        .where((element) => element.timerType != 3)
        .toList()
        .reversed
        .toList();
  }

  Future<List<MatchModel>> getFinishedMatches() async {
    Database db = await instance.database;
    var matches = await db.query('matches');
    return matches
        .map((e) => MatchModel.fromMap(e))
        .toList()
        .where((element) => element.timerType == 3)
        .toList()
        .reversed
        .toList();
  }

  Future<List<RoundModel>> getRounds() async {
    Database db = await instance.database;
    var rounds = await db.query('rounds');
    return rounds.map((e) => RoundModel.fromMap(e)).toList();
  }

  Future<List<HistoryModel>> getHistory() async {
    Database db = await instance.database;
    var history = await db.query('history');
    return history.map((e) => HistoryModel.fromMap(e)).toList();
  }

  Future<List<HistoryModel>> getHistoryById(int id) async {
    Database db = await instance.database;
    var history =
        await db.query('history', where: 'match_id = ?', whereArgs: [id]);
    return history
        .map((e) => HistoryModel.fromMap(e))
        .toList()
        .reversed
        .toList();
  }

  //MatchModel
  Future<int?> addMatch(MatchModel matchModel) async {
    Database db = await instance.database;
    return await db.insert('matches', matchModel.toMap());
  }

  Future<int?> deleteMatchById(MatchModel matchModel) async {
    Database db = await instance.database;
    return db.delete('matches', where: 'id = ?', whereArgs: [matchModel.id]);
  }

  Future<int?> updateMatchById(MatchModel matchModel) async {
    Database db = await instance.database;
    return db.update('matches', matchModel.toMap(),
        where: 'id = ?', whereArgs: [matchModel.id]);
  }

  Future<MatchModel?> getActiveMatchesById(int id) async {
    Database db = await instance.database;
    var match = await db.query('matches', where: 'id = ?', whereArgs: [id]);
    return match.map((e) => MatchModel.fromMap(e)).toList().isNotEmpty
        ? match.map((e) => MatchModel.fromMap(e)).toList().first
        : null;
  }

  //RoundModel
  Future<int?> addRound(RoundModel roundModel) async {
    Database db = await instance.database;
    return await db.insert('rounds', roundModel.toMap());
  }

  Future<int?> deleteRounds(MatchModel matchModel) async {
    Database db = await instance.database;
    return db.delete('rounds', where: 'id = ?', whereArgs: [matchModel.id]);
  }

  Future<List<RoundModel>> getRoundsById(int id) async {
    Database db = await instance.database;
    var rounds = await db.query(
      'rounds',
      where: 'id = ?',
      whereArgs: [id],
    );
    return rounds.map((e) => RoundModel.fromMap(e)).toList();
  }

  //HistoryModel
  Future<int?> addHistory(HistoryModel historyModel) async {
    Database db = await instance.database;
    return await db.insert('history', historyModel.toMap());
  }

  Future<int?> deleteHistory(MatchModel matchModel) async {
    Database db = await instance.database;
    return db
        .delete('history', where: 'match_id = ?', whereArgs: [matchModel.id]);
  }

  Future<int?> deleteOneHistory(HistoryModel historyModel) async {
    Database db = await instance.database;
    return db.delete('history',
        where: 'id = ? and match_id = ? and name_of_team = ? and time = ?',
        whereArgs: [
          historyModel.id,
          historyModel.matchId,
          historyModel.nameOfTeam,
          historyModel.time
        ]);
  }
}
