import 'dart:collection';

class Player {
  String name;
  List<Game>? games;
  String bio = '';

  Player(this.name);
}

class Game {
  String name;
  int experience;
  List<Format>? formats;

  Game(this.name, this.experience, this.formats);
}

class Format {
  String name;
  Level level;

  Format(this.name, this.level);
}

enum Level {
  casual,
  competitive,
  any,
}

extension LevelExtension on Level {
  String get name {
    switch (this) {
      case Level.casual:
        return 'Casual';
      case Level.competitive:
        return 'Competitive';
      case Level.any:
        return 'Any';
    }
  }
}