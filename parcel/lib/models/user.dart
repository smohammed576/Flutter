class User{
  String id;
  String name;
  String email;

  User({
    required this.id,
    required this.name,
    required this.email
  });

  Map<String, dynamic> toMap(){
    return {
      'id': id,
      'name': name,
      'email': email
    };
  }

  factory User.fromMap(Map<String, dynamic> map) => User(
    id: map['id'], 
    name: map['name'], 
    email: map['email']
  );
}