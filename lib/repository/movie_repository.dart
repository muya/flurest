import 'package:flurest/api_key.dart';
import 'package:flurest/models/movie_response.dart';
import 'package:flurest/networking/api_base_helper.dart';

class MovieRepository {
  final String _apiKey = apiKey;

  final ApiBaseHelper _helper = ApiBaseHelper();

  Future<List<Movie>> fetchMovieList() async {
    final response = await _helper.get('movie/popular?api_key=$_apiKey');

    return MovieResponse.fromJson(response).results;
  }
}
