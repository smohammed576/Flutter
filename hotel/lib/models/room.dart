class Room {
  int number;
  String color;
  String curtains;
  String music;
  int locked;
  double climate;
  int disturb;
  int makeup;

  Room({
    required this.number,
    required this.color,
    required this.curtains,
    required this.music,
    required this.locked,
    required this.climate,
    required this.disturb,
    required this.makeup,
  });

  factory Room.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'room_number': int number,
        'room_colour': String color,
        'curtains': String curtains,
        'music': String music,
        'locked': int locked,
        'climate': double climate,
        'do_not_disturb': int disturb,
        'make_up_room': int makeup,
      } =>
        Room(
          number: number,
          color: color,
          curtains: curtains,
          music: music,
          locked: locked,
          climate: climate,
          disturb: disturb,
          makeup: makeup,
        ),
      _ => throw const FormatException('failed'),
    };
  }
}
