import 'package:hive/hive.dart';

part 'snack.g.dart';

@HiveType(typeId: 0)
class Snack extends HiveObject{
  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String image;

  @HiveField(3)
  String description;

  @HiveField(4)
  String country;

  @HiveField(5)
  String flag;

  @HiveField(6)
  String userId;

  @HiveField(7)
  int amount;

  @HiveField(8)
  bool isSwapped;

  Snack({required this.id, required this.name, required this.image, required this.description, required this.country, required this.flag, required this.userId, required this.amount, this.isSwapped = false});

}