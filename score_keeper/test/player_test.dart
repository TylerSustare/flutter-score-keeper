import 'package:score_keeper/player.dart';
import "package:test/test.dart";

void main() {
  test('Player default constructor', () {
    Player p1 = new Player();
    expect(p1.name, null);
    expect(p1.score, 0);
  });
  test('Player constructor with name', () {
    Player p1 = new Player(name: 'Joe');
    expect(p1.name, 'Joe');
    expect(p1.score, 0);
  });
  test('Player constructor with name and score', () {
    Player p1 = new Player(name: 'Joe', score: 22);
    expect(p1.name, 'Joe');
    expect(p1.score, 22);
  });
  test('Player constructor with score, but no name', () {
    try {
      new Player(score: 22);
    } catch (e) {
      expect(
          e.toString(), 'Exception: MUST_HAVE_A_NAME_TO_INITIALIZE_WITH_SCORE');
      return;
    }
    expect('to not reach this line. Expected error case', true);
  });
  test('Counter value should be incremented', () {
    final Player p1 = new Player(name: 'Steve');
    p1.incrementScore();
    expect(p1.score, 1);
  });
  test('Counter value should be decremented', () {
    final Player p1 = new Player(name: 'Steve', score: 100);
    p1.decrementScore();
    expect(p1.score, 99);
    p1.decrementScore();
    p1.decrementScore();
    expect(p1.score, 97);
  });
  test('addScore method', () {
    final Player p1 = new Player(name: 'Sally');
    expect(p1.score, 0);
    p1.addScore(scoreToAdd: 3);
    expect(p1.score, 3);
  });
  test('removeScore method', () {
    final Player p1 = new Player(name: 'Sally', score: 20);
    expect(p1.score, 20);
    p1.subtractScore(scoreToSubtract: 3);
    expect(p1.score, 17);
  });
  test('resetScore method', () {
    final Player p1 = new Player(name: 'Sally', score: 20);
    expect(p1.score, 20);
    p1.resetScore();
    expect(p1.score, 0);
  });

}
