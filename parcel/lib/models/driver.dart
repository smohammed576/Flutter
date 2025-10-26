class Driver{
  String name;
  String image;
  double rating;

  Driver({
    required this.name,
    required this.image,
    required this.rating
  });

  factory Driver.fromJson(Map<String, dynamic> json) => Driver(
    name: json['name'],
    image: json['image'],
    rating: json['rating']
  );
}