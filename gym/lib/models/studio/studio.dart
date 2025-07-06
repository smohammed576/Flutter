import 'package:gym/models/studio/day.dart';

class Studio {
  String name;
  Map<String, StudioDay?> openingHours;
  String? news;

  Studio({required this.name, required this.openingHours, this.news});

  factory Studio.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> getData = json['opening_hours'];
    Map<String, StudioDay?> data = {};
    getData.forEach((day, item) {
      if (item != null) {
        data[day] = StudioDay.fromJson(item);
      } else {
        data[day] = null;
      }
    });
    return Studio(name: json['name'], openingHours: data, news: json['news']);
  }
}
