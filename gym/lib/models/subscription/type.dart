class SubscriptionType {
  String price;
  SubscriptionType({required this.price});

  factory SubscriptionType.fromJson(Map<String, dynamic> json) =>
      SubscriptionType(price: json['monthly_price_eur']);
}
