import 'dart:async';
import 'dart:developer' as developer;

import 'package:flurest/models/movie_response.dart';
import 'package:flurest/networking/api_response.dart';
import 'package:flurest/repository/movie_repository.dart';

class MovieBloc {
  MovieRepository _movieRepository;

  StreamController _movieListController;

  StreamSink<ApiResponse<List<Movie>>> get  movieListSink => _movieListController.sink;

  Stream<ApiResponse<List<Movie>>> get movieListStream => _movieListController.stream;

  MovieBloc() {
    _movieListController = StreamController<ApiResponse<List<Movie>>>();
    _movieRepository =  MovieRepository();
    fetchMovieList();
  }

  fetchMovieList() async {
    movieListSink.add(ApiResponse.loading('Fetching movies'));

    try {
      List<Movie> movies = await _movieRepository.fetchMovieList();

      movieListSink.add(ApiResponse.completed('Completed fetching movies', movies));
    } catch (e) {
      movieListSink.add(ApiResponse.error(e.toString()));
      developer.log('Error fetching movies list');
    }
  }

  dispose() {
    _movieListController?.close();
  }
}
