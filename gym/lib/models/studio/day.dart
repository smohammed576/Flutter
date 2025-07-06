class StudioDay {
  String? from;
  String? until;
  List<int>? occupancies;

  StudioDay({this.from, this.until, this.occupancies});

  factory StudioDay.fromJson(Map<String, dynamic> json) => StudioDay(
    from: json['from'],
    until: json['until'],
    occupancies: List<int>.from(json['occupancies']),
  );
}
