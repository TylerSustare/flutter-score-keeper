import 'package:score_keeper/models/player.dart';
import 'package:score_keeper/models/game.dart';
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

  test('test is game over', (){
    setUp();
    Game game = new Game(players: players);
    expect(game.isGameOver(), false); // goal has not been set
    game.goal = 4;
    expect(game.isGameOver(), false); // goal has not been met
    game.players[0].incrementScore();
    expect(game.isGameOver(), false);
    game.players[0].incrementScore();
    expect(game.isGameOver(), true);
  });
}
