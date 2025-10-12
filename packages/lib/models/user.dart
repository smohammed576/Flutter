class User{
  String id;
  String username;
  String password;
  String? image;

  User({required this.id, required this.username, required this.password, this.image});

  Map<String, dynamic> toMap(){
    return {
      'id': id,
      'username': username,
      'password': password,
      'image': image
    };
  }

  factory User.fromMap(Map<String, dynamic> map) => User(
    id: map['id'], 
    username: map['username'], 
    password: map['password'],
    image: map['image']
  );
}