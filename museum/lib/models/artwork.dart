class Artwork{
  String title;
  String years;
  String birthplace;
  String comment;

  Artwork({required this.title, required this.years, required this.birthplace, required this.comment});

  factory Artwork.fromJson(Map<String, dynamic> json) =>
  Artwork(
    title: json['title'], 
    years: json['years'], 
    birthplace: json['born_at'], 
    comment: json['comment']
  );
}