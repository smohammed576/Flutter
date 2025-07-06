class Broadcast {
  String date;
  String message;

  Broadcast({required this.date, required this.message});

  factory Broadcast.fromJson(Map<String, dynamic> json) =>
      Broadcast(date: json['created_on'], message: json['message']);
}
