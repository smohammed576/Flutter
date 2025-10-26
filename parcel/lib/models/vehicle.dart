class Vehicle{
  String name;
  String image;
  int price;
  int duration;

  Vehicle({
    required this.name,
    required this.image,
    required this.price,
    required this.duration
  });

  factory Vehicle.fromJson(Map<String, dynamic> json) => Vehicle(
    name: json['name'],
    image: json['image'],
    price: json['price'],
    duration: json['duration']
  );
}