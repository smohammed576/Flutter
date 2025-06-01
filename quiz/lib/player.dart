class Player{
  final String name;
  final String imagePath;
  final int? score;
  final int? time;

  Player({required this.name, required this.imagePath, this.score, this.time});

  Map<String, dynamic> toJson() => {
    'name': name,
    'imagePath': imagePath,
    'score': score,
    'time': time
  };

  factory Player.fromJson(Map<String, dynamic> json) => Player(
    name: json['name'],
    imagePath: json['imagePath'],
    score: json['score'],
    time: json['time']
  );
}