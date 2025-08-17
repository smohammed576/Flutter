import 'package:hive/hive.dart';

part 'smoothie.g.dart';

@HiveType(typeId: 0)

class Smoothie extends HiveObject{
  @HiveField(0)
  String id;
  @HiveField(1)
  String name;
  @HiveField(2)
  List<String> options;
  Smoothie({required this.id, required this.name, required this.options});
}