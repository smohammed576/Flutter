import 'dart:convert';
import 'dart:math';

import 'package:packages/models/film.dart';
import 'package:http/http.dart' as http;

class ApiService{
  final String base = "https://api.themoviedb.org/3";
  final String key = "13631cc9bf997aabaa47ab22c3ee1f67";

  Future<Film> getRandomFilm() async {
    final response = await http.get(
      Uri.parse('$base/movie/top_rated?api_key=$key')
    );
    if(response.statusCode == 200){
      final data = json.decode(response.body);
      final List results = data['results'];
      final List<Film> films = results.map((item) => Film.fromJson(item)).toList();
      final int randomNumber = Random().nextInt(20);
      return films[randomNumber];
    } else{
      throw Exception('failed');
    }
  }

  Future<List<Film>> searchFilms(String query) async {
    final response = await http.get(
      Uri.parse('$base/search/movie?query=$query&api_key=$key')
    );
    if(response.statusCode == 200){
      print(query);
      final data = json.decode(response.body);
      final List results = data['results'];
      return results.map((item) => Film.fromJson(item)).toList();
    } else{
      throw Exception('failed');
    }
  }
}