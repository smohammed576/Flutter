class Topic{
  String title;
  String image;
  List<String> colors;
  bool isLarge;

  Topic({required this.title, required this.image, required this.colors, required this.isLarge});

  factory Topic.fromJson(Map<String, dynamic> json) {
    List<String> colors = [];
    for(var item in json['colors']){
      colors.add(item);
    }
    return Topic(
    title: json['title'], 
    image: json['image'], 
    colors: colors, 
    isLarge: json['isLarge']
  );
  }
}