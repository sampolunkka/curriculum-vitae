class Position {
  final String title;
  final String company;  
  final DateTime start;
  final DateTime end;
  final String description;

  Position(this.title, this.company, this.start, this.end, this.description);

  static Position fromJson(Map<String, dynamic> json) {
    return Position(
      json['title'],
      json['company'],
      DateTime.parse(json['start']),
      DateTime.parse(json['end']),
      json['description']
    );
  }
}