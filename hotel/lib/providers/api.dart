import 'dart:convert';

import 'package:hotel/models/room.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final String url = 'http://104.248.94.175';
  final String token = '2|iFcgqcPIhCxMxSTRQLHtYLEmwE94u18aplPUMKwT20081088';

  Future<Room> getRoom() async {
    final session = await http.post(
      Uri.parse("$url/api/start"),
      headers: {'Authorization': 'Bearer $token'},
    );
    if (session.statusCode != 200) {
      throw Exception('no session');
    }
    final response = await http.post(
      Uri.parse("$url/api/room"),
      headers: {'Authorization': 'Bearer $token'},
    );
    if (response.statusCode == 200) {
      // return Room.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
      print(response.body);
      return Room.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('failed');
    }
  }

  Future<Room> changeSettings(String service, dynamic value) async {
    await http.post(
      Uri.parse("$url/api/change"),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'service': service, 'value': value})
    );
    final response = await http.post(
      Uri.parse("$url/api/room"),
      headers: {'Authorization': 'Bearer $token'}
    );
    if(response.statusCode == 200){
      print(response.body);
      return Room.fromJson(jsonDecode(response.body));
    }
    else{
      throw Exception('failed');
    }
  }
}
