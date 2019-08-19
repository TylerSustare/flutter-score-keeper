import 'package:score_keeper/player.dart';

class Game {
  Game({List<Player> players, double goal}) {
    this.players = players;
    this.goal = goal ?? 0;

    if (this.players == null) {
      throw new Exception('MUST_HAVE_PLAYERS_TO_PLAY_A_GAME');
    }
  }
  List<Player> players;
  double goal;

  void addPlayer(Player player) => players.add(player);
}
