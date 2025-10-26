class Type{
  String label;
  String image;
  Type({
    required this.label,
    required this.image
  });

  factory Type.fromJson(Map<String, dynamic> json) => Type(
    label: json['label'], 
    image: json['image']
  );
}