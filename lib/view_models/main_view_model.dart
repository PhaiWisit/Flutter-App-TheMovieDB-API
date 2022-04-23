import 'package:flutter/foundation.dart';
import 'package:flutter_moviedb_api/models/move_error.dart';
import 'package:flutter_moviedb_api/models/movie_model.dart';
import 'package:flutter_moviedb_api/services/api_status.dart';
import 'package:flutter_moviedb_api/services/movie_service.dart';

class MainViewModel extends ChangeNotifier {
  bool _loading = false;
  bool _error = false;
  MovieModel? _movieModel;
  List<Result> _popularList = [];
  MovieError _movieError = MovieError(code: 0, massage: 'massage');

  bool get loading => _loading;
  bool get error => _error;
  MovieModel? get movieModel => _movieModel;
  List<Result> get popularList => _popularList;
  MovieError get movieError => _movieError;

  MainViewModel() {
    getPopular();
  }

  setLoading(bool loading) {
    _loading = loading;
    notifyListeners();
  }

  setError(bool error) {
    _error = error;
    notifyListeners();
  }

  setMovieModel(MovieModel movieModel) {
    _movieModel = movieModel;
  }

  setMovieError(MovieError movieError) {
    _movieError = movieError;
  }

  setPopular(MovieModel movieModel) {
    int resLength = movieModel.results.length;
    print("resLength is " + resLength.toString());
    for (int i = 0; i < resLength; i++) {
      _popularList.add(movieModel.results[i]);
      print('adding ' + movieModel.results[i].originalTitle);
    }
  }

  getPopular() async {
    setLoading(true);
    var response = await MovieService.getPopular();
    if (response is Success) {
      await setMovieModel(response.response as MovieModel);
      print('GET MOVIE POPULAR SUCCESS');
      setPopular(_movieModel!);
    }
    if (response is Failure) {
      MovieError movieError = MovieError(
          code: response.code, massage: response.errorResponse.toString());
      setMovieError(movieError);
      setError(true);
    }
    setLoading(false);
  }
}
