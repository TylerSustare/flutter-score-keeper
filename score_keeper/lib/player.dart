class Player {
  Player({String name, double score}) {
    this.name = name;
    this.score = score ?? 0;

    if (this.name == null && this.score > 0) {
      throw new Exception('MUST_HAVE_A_NAME_TO_INITIALIZE_WITH_SCORE');
    }
  }
  String name;
  double score;

  void incrementScore() => this.score++;
  void decrementScore() => this.score--;
  void addScore({double scoreToAdd}) => this.score += scoreToAdd;
  void subtractScore({double scoreToSubtract}) => this.score -= scoreToSubtract;
}
