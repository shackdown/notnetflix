import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:notnetflix/models/movie.dart';
import 'package:notnetflix/services/api_service.dart';

class DataRepository with ChangeNotifier {
  final APIService apiService = APIService();
  final List<Movie> _popularMovieList = [];
  int _popularMoviePageIndex = 1;
  final List<Movie> _playingNowMovieList = [];
  int _playingNowMoviePageIndex = 1;
  final List<Movie> _upcomingMovieList = [];
  int _upcomingMoviePageIndex = 1;
  final List<Movie> _animationMovieList = [];
  int _animationMoviePageIndex = 1;

  // getters
  List<Movie> get popularMovieList => _popularMovieList;
  List<Movie> get playingNowMovieList => _playingNowMovieList;
  List<Movie> get upcomingMovieList => _upcomingMovieList;
  List<Movie> get animationMovieList => _animationMovieList;

  Future<void> getPopularMovies() async {
    try {
      List<Movie> movies =
          await apiService.getPopularMovies(pageNumber: _popularMoviePageIndex);
      _popularMovieList.addAll(movies);
      _popularMoviePageIndex++;
      notifyListeners();
    } on Response catch (response) {
      print("ERROR: ${response.statusCode}");
      rethrow;
    }
  }

  Future<void> getPlayingNow() async {
    try {
      List<Movie> movies =
          await apiService.getNowPlaying(pageNumber: _playingNowMoviePageIndex);
      _playingNowMovieList.addAll(movies);
      _playingNowMoviePageIndex++;
      notifyListeners();
    } on Response catch (response) {
      print("ERROR: ${response.statusCode}");
      rethrow;
    }
  }

  Future<void> getUpcoming() async {
    try {
      List<Movie> movies =
          await apiService.getUpcoming(pageNumber: _upcomingMoviePageIndex);
      _upcomingMovieList.addAll(movies);
      _upcomingMoviePageIndex++;
      notifyListeners();
    } on Response catch (response) {
      print("ERROR: ${response.statusCode}");
      rethrow;
    }
  }

  Future<void> getAnimationMovies() async {
    try {
      List<Movie> movies = await apiService.getAnimationMovies(
          pageNumber: _animationMoviePageIndex);
      _animationMovieList.addAll(movies);
      _animationMoviePageIndex++;
      notifyListeners();
    } on Response catch (response) {
      print("ERROR: ${response.statusCode}");
      rethrow;
    }
  }

  Future<Movie> getMovieDetail({required Movie movie}) async {
    try {
      // information sur le film
      // Movie newMovie = await apiService.getMovieDetail(movie: movie);
      // information sur la vidéo "trailer"
      // newMovie = await apiService.getMovieVideos(movie: newMovie);
      // information sur le casting
      //newMovie = await apiService.getMovieCast(movie: newMovie);
      // information sur les images
      // newMovie = await apiService.getMovieImages(movie: newMovie);
      Movie newMovie = await apiService.getMovie(movie: movie);
      return newMovie;
    } on Response catch (response) {
      print("ERROR: ${response.statusCode}");
      rethrow;
    }
  }

  Future<void> initData() async {
    await Future.wait([
      getPopularMovies(),
      getPlayingNow(),
      getUpcoming(),
      getAnimationMovies()
    ]);
  }
}
