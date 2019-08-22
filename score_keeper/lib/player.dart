class Player {
  Player({String name, int score}) {
    this.name = name;
    this.score = score ?? 0;

    if (this.name == null && this.score > 0) {
      throw new Exception('MUST_HAVE_A_NAME_TO_INITIALIZE_WITH_SCORE');
    }
  }
  String name;
  int score;

  void incrementScore([int incrementAmount]) =>
      this.score += incrementAmount ?? 1;
  void decrementScore([int decrementAmount]) =>
      this.score -= decrementAmount ?? 1;
  void addScore({int scoreToAdd}) => this.score += scoreToAdd;
  void subtractScore({int scoreToSubtract}) => this.score -= scoreToSubtract;
  void resetScore() => this.score = 0;
}
