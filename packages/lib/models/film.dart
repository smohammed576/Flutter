class Film{
  int id;
  String title;
  String? poster;

  Film({required this.id, required this.title, this.poster});

  factory Film.fromJson(Map<String, dynamic> json) => Film(
    id: json['id'],
    title: json['title'],
    poster: json['poster_path']
  );

  
}