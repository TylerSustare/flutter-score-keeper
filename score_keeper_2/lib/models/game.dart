import 'package:score_keeper_2/models/player.dart';

class Game {
  Game({List<Player> players, int goal}) {
    this.players = players;
    this.incrementValue = 1;
    this.decrementValue = 1;

    if (this.players == null) {
      throw new Exception('MUST_HAVE_PLAYERS_TO_PLAY_A_GAME');
    }
  }
  List<Player> players;
  int goal;
  int incrementValue;
  int decrementValue;

  void addPlayer(Player player) => players.add(player);

  bool isGameOver() {
    if (goal != null) {
      for (var player in this.players) {
        if (player.score >= this.goal) {
          return true;
        }
      }
    }
    return false;
  }
}
