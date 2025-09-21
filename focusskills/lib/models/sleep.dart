class Sleep{
  String title;
  String subtitle;
  String image;

  Sleep({required this.title, required this.subtitle, required this.image});

  factory Sleep.fromJson(Map<String, dynamic> json) => Sleep(
    title: json['title'], 
    subtitle: json['subtitle'], 
    image: json['image']
  );
}