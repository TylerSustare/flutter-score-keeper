import 'package:score_keeper/player.dart';
import 'package:score_keeper/game.dart';
import "package:test/test.dart";

void main() {
  List<Player> players = new List<Player>();

  setUp() {
    players = <Player>[
      Player(name: 'p1', score: 2),
    ];
  }

  tearDown() {
    players = new List<Player>();
  }

  test('Player default constructor', () {
    Player p1 = new Player();
    List<Player> ps = new List<Player>();
    ps.add(p1);
    Game game = new Game(players: ps);
    expect(game.players[0].name, null);
    expect(game.players[0].score, 0);
  });

  test('constructor with names and score', () {
    setUp();
    Game game = new Game(players: players);
    expect(game.players[0].name, 'p1');
    expect(game.players[0].score, 2);
    tearDown();
  });
}
