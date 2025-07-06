class Subscription {
  String type;
  String expiration;

  Subscription({required this.type, required this.expiration});

  factory Subscription.fromJson(Map<String, dynamic> json) =>
      Subscription(type: json['type'], expiration: json['expiration_date']);
}
