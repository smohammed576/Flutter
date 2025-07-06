import 'package:gym/models/subscription/subscription.dart';

class Member {
  String firstname;
  String lastname;
  String dateOfBirth;
  Subscription? subscription;

  Member({
    required this.firstname,
    required this.lastname,
    required this.dateOfBirth,
    this.subscription,
  });

  factory Member.fromJson(Map<String, dynamic> json) => Member(
    firstname: json['first_name'],
    lastname: json['last_name'],
    dateOfBirth: json['date_of_birth'],
    subscription: Subscription.fromJson(json['subscription']),
  );
}
