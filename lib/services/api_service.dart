import 'package:dio/dio.dart';
import 'package:notnetflix/models/movie.dart';
import 'package:notnetflix/models/person.dart';
import 'package:notnetflix/services/api.dart';

class APIService {
  final API api = API();
  final Dio dio = Dio();

  Future<Response> getData(String path, {Map<String, dynamic>? params}) async {
    // on construit l'url que l'on va appeler
    String url = api.baseURL + path;

    // on construit les paramètres de la requête
    // ces paramètres seront présents dans chaque requête
    Map<String, dynamic> query = {
      'api_key': api.apiKey,
      'language': 'fr-FR',
    };

    // si des paramètres sont passés, on les ajoute à _query
    if (params != null) {
      query.addAll(params);
    }

    // on fait l'appel
    final response = await dio.get(url, queryParameters: query);

    // la requête est OK?
    if (response.statusCode == 200) {
      return response;
    } else {
      throw response;
    }
  }

  Future<List<Movie>> getPopularMovies({required int pageNumber}) async {
    Response response = await getData('/movie/popular', params: {
      'page': pageNumber,
    });

    if (response.statusCode == 200) {
      Map data = response.data;
      List<dynamic> results = data['results'];
      List<Movie> movies = [];
      for (Map<String, dynamic> json in results) {
        Movie movie = Movie.fromJson(json);
        movies.add(movie);
      }
      return movies;
    } else {
      throw response;
    }
  }

  Future<List<Movie>> getNowPlaying({required int pageNumber}) async {
    Response response = await getData('/movie/now_playing', params: {
      'page': pageNumber,
    });

    if (response.statusCode == 200) {
      Map data = response.data;
      List<Movie> movies = data['results'].map<Movie>((dynamic movieJson) {
        return Movie.fromJson(movieJson);
      }).toList();
      return movies;
    } else {
      throw response;
    }
  }

  Future<List<Movie>> getUpcoming({required int pageNumber}) async {
    Response response = await getData('/movie/upcoming', params: {
      'page': pageNumber,
    });

    if (response.statusCode == 200) {
      Map data = response.data;
      List<Movie> movies = data['results'].map<Movie>((dynamic movieJson) {
        return Movie.fromJson(movieJson);
      }).toList();
      return movies;
    } else {
      throw response;
    }
  }

  Future<List<Movie>> getAnimationMovies({required int pageNumber}) async {
    Response response = await getData('/discover/movie',
        params: {'page': pageNumber, 'with_genres': '16'});

    if (response.statusCode == 200) {
      Map data = response.data;
      List<Movie> movies = data['results'].map<Movie>((dynamic movieJson) {
        return Movie.fromJson(movieJson);
      }).toList();
      return movies;
    } else {
      throw response;
    }
  }

  /*Future<Movie> getMovieDetail({required Movie movie}) async {
    Response response = await getData('/movie/${movie.id}');
    if (response.statusCode == 200) {
      Map<String, dynamic> _data = response.data;
      var genres = _data['genres'] as List;
      List<String> genresList = genres.map((item) {
        return item['name'] as String;
      }).toList();
      Movie newMovie = movie.copyWith(
          genres: genresList,
          releaseDate: _data['release_date'],
          vote: _data['vote_average']);
      return newMovie;
    } else {
      throw response;
    }
  }

  Future<Movie> getMovieVideos({required Movie movie}) async {
    Response response = await getData('/movie/${movie.id}/videos');
    if (response.statusCode == 200) {
      Map _data = response.data;
      List<String> videoKeys =
          _data['results'].map<String>((dynamic videoJson) {
        return videoJson['key'] as String;
      }).toList();
      return movie.copyWith(videos: videoKeys);
    } else {
      throw response;
    }
  }

  Future<Movie> getMovieCast({required Movie movie}) async {
    Response response = await getData('/movie/${movie.id}/credits');
    if (response.statusCode == 200) {
      Map _data = response.data;
      List<Person> _casting = _data['cast'].map<Person>((dynamic personJson) {
        return Person.fromJson(personJson);
      }).toList();
      return movie.copyWith(casting: _casting);
    } else {
      throw response;
    }
  }

  Future<Movie> getMovieImages({required Movie movie}) async {
    Response response = await getData('/movie/${movie.id}/images',
        params: {'include_image_language': 'null'});
    if (response.statusCode == 200) {
      Map _data = response.data;
      List<String> imagesPath =
          _data['backdrops'].map<String>((dynamic imageJson) {
        return imageJson['file_path'] as String;
      }).toList();
      return movie.copyWith(images: imagesPath);
    } else {
      throw response;
    }
  }
  */

  Future<Movie> getMovie({required Movie movie}) async {
    Response response = await getData('/movie/${movie.id}', params: {
      'include_image_language': 'null',
      'append_to_response': 'videos,images,credits'
    });
    if (response.statusCode == 200) {
      Map _data = response.data;

      // récuperation des genres
      var genres = _data['genres'] as List;
      List<String> genresList = genres.map((item) {
        return item['name'] as String;
      }).toList();

      // on recupère les videos
      List<String> videoKeys =
          _data['videos']['results'].map<String>((dynamic videoJson) {
        return videoJson['key'] as String;
      }).toList();

      // on recupère les photos
      List<String> imagesPath =
          _data['images']['backdrops'].map<String>((dynamic imageJson) {
        return imageJson['file_path'] as String;
      }).toList();

      // on recupère le casting
      List<Person> casting =
          _data['credits']['cast'].map<Person>((dynamic personJson) {
        return Person.fromJson(personJson);
      }).toList();

      return movie.copyWith(
          genres: genresList,
          images: imagesPath,
          videos: videoKeys,
          casting: casting,
          releaseDate: _data['release_date'],
          vote: _data['vote_average']);
    } else {
      throw response;
    }
  }
}
