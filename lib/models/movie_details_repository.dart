
import 'package:flurest/api_key.dart';
import 'package:flurest/models/movie_response.dart';
import 'package:flurest/networking/api_base_helper.dart';

class MovieDetailRepository {
  final String _apiKey = apiKey;

  final ApiBaseHelper _helper = ApiBaseHelper();

  Future<Movie> fetchMovieDetail(int selectedMovieId) async {
    final response = await _helper.get('movie/$selectedMovieId?apiKey=$_apiKey');

    return Movie.fromJson(response);
  }
}
