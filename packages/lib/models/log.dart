class Log{
  int id;
  String title;
  String? poster;
  bool watched;
  bool liked;
  bool watchlisted;
  String user;
  DateTime createdAt;

  Log({
    required this.id,
    required this.title,
    this.poster,
    required this.watched,
    required this.liked,
    required this.watchlisted,
    required this.user,
    required this.createdAt
  });

  Map<String, dynamic> toMap(){
    return {
      'id': id,
      'title': title,
      'poster': poster,
      'watched': watched ? 1 : 0,
      'liked': liked ? 1 : 0,
      'watchlisted': watchlisted ? 1 : 0,
      'user': user,
      'createdAt': createdAt.toIso8601String()
    };
  }
  
  factory Log.fromMap(Map<String, dynamic> map) => Log(
    id: map['id'], 
    title: map['title'], 
    poster: map['poster'],
    watched: map['watched'] == 1, 
    liked: map['liked'] == 1, 
    watchlisted: map['watchlisted'] == 1,
    user: map['user'],
    createdAt: DateTime.parse(map['createdAt'])
  );
}