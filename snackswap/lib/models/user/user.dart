import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: 1)
class User extends HiveObject{
  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String image;

  @HiveField(3)
  String country;

  @HiveField(4)
  String flag;

  @HiveField(5)
  int swaps;

  User({required this.id, required this.name, required this.image, required this.country, required this.flag, this.swaps = 0});
}