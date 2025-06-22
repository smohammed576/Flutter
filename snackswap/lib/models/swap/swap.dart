import 'package:snackswap/models/request/request.dart';

class Swap{
  final Request request;
  final String username;
  final String pfp;
  final String snackname;
  final String image;
  final String snack;

  Swap({required this.request, required this.username, required this.pfp, required this.snackname, required this.image, required this.snack});
}