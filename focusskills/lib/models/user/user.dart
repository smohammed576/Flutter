import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: 0)
class User extends HiveObject{
  @HiveField(0)
  String id;
  @HiveField(1)
  String name;
  @HiveField(2)
  String email;
  @HiveField(3)
  String password;
  @HiveField(4)
  String? focus;
  @HiveField(5)
  DateTime? time;
  @HiveField(6)
  List<int>? days;

  User({required this.id, required this.name, required this.email, required this.password, this.focus, this.time, this.days});
}