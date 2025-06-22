import 'package:hive/hive.dart';

part 'request.g.dart';

@HiveType(typeId: 2)

enum Status{
  @HiveField(0)
  pending,
  @HiveField(1)
  accepted,
  @HiveField(2)
  declined,
  @HiveField(3)
  cancelled
}

@HiveType(typeId: 3)

class Request extends HiveObject{
  @HiveField(0)
  String id;

  @HiveField(1)
  String user;

  @HiveField(2)
  String sendUser;

  @HiveField(3)
  String snack;

  @HiveField(4)
  String requestSnack;

  @HiveField(5)
  Status status;

  Request({required this.id, required this.user, required this.sendUser, required this.snack, required this.requestSnack, this.status = Status.pending});
}