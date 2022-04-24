import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_moviedb_api/models/move_error.dart';
import 'package:flutter_moviedb_api/models/movie_popular_model.dart' as Popular;
import 'package:flutter_moviedb_api/models/movie_trailer_model.dart' as Trailer;
import 'package:flutter_moviedb_api/models/movie_trend_model.dart' as Trend;
import 'package:flutter_moviedb_api/services/api_status.dart';
import 'package:flutter_moviedb_api/services/movie_service.dart';

class MainViewModel extends ChangeNotifier {
  bool _loading = false;
  bool _error = false;
  Popular.MoviePopularModel? _moviePopularModel;
  Trend.MovieTrendModel? _movieTrendModel;
  Trailer.MovieTrailerModel? _movieTrailerModel;
  List<Popular.Result> _popularList = [];
  List<Trend.Result> _trendList = [];
  List<Trailer.Result> _trailerList = [];
  MovieError _movieError = MovieError(code: 0, massage: 'massage');

  bool get loading => _loading;
  bool get error => _error;
  Popular.MoviePopularModel? get moviePopularModel => _moviePopularModel;
  Trend.MovieTrendModel? get movieTrendModel => _movieTrendModel;
  Trailer.MovieTrailerModel? get movieTrailerModel => _movieTrailerModel;
  List<Popular.Result> get popularList => _popularList;
  List<Trend.Result> get trendList => _trendList;
  List<Trailer.Result> get trailerList => _trailerList;
  MovieError get movieError => _movieError;

  void main() async {
    await setLoading(true);
    await getPopular();
    await getTrend();
    await getTrailer();
    await setLoading(false);
  }

  MainViewModel() {
    main();
    // getPopular();
    // getTrend();
    // getTrailer();
  }

  setLoading(bool loading) {
    _loading = loading;
    notifyListeners();
  }

  setError(bool error) {
    _error = error;
    notifyListeners();
  }

  setMoviePopularModel(Popular.MoviePopularModel moviePopularModel) {
    _moviePopularModel = moviePopularModel;
  }

  setMovieTrendModel(Trend.MovieTrendModel movieTrendModel) {
    _movieTrendModel = movieTrendModel;
  }

  setMovieTrailerModel(Trailer.MovieTrailerModel movieTrailerModel) {
    _movieTrailerModel = movieTrailerModel;
  }

  setMovieError(MovieError movieError) {
    _movieError = movieError;
  }

  setPopular(Popular.MoviePopularModel movieModel) async {
    _popularList = [];
    int resLength = movieModel.results.length;
    for (int i = 0; i < resLength; i++) {
      _popularList.add(movieModel.results[i]);
    }
  }

  setTrend(Trend.MovieTrendModel movieTrendModel) {
    int resLength = movieTrendModel.results.length;
    _trendList = [];
    for (int i = 0; i < resLength; i++) {
      _trendList.add(movieTrendModel.results[i]);
    }
  }

  setTrailer(Trailer.MovieTrailerModel movieTrailerModel) {
    int resLength = movieTrailerModel.results.length;
    _trailerList = [];
    List randomList = shuffle(movieTrailerModel.results);
    for (int i = 0; i < resLength; i++) {
      _trailerList.add(randomList[i]);
    }
  }

  getPopular() async {
    setLoading(true);
    var response = await MovieService.getPopular();
    if (response is Success) {
      await setMoviePopularModel(
          response.response as Popular.MoviePopularModel);
      print('GET MOVIE POPULAR SUCCESS');
      setPopular(_moviePopularModel!);
    }
    if (response is Failure) {
      MovieError movieError = MovieError(
          code: response.code, massage: response.errorResponse.toString());
      setMovieError(movieError);
      setError(true);
    }
    setLoading(false);
  }

  getTrend() async {
    setLoading(true);
    var response = await MovieService.getTrend();
    if (response is Success) {
      await setMovieTrendModel(response.response as Trend.MovieTrendModel);
      print('GET MOVIE TREND SUCCESS');
      setTrend(_movieTrendModel!);
    }
    if (response is Failure) {
      print('GET MOVIE TREND Failure');
      MovieError movieError = MovieError(
          code: response.code, massage: response.errorResponse.toString());
      setMovieError(movieError);
      setError(true);
    }
    setLoading(false);
  }

  getTrailer() async {
    setLoading(true);
    var response = await MovieService.getTrailer();
    if (response is Success) {
      await setMovieTrailerModel(
          response.response as Trailer.MovieTrailerModel);
      print('GET MOVIE TRAILER SUCCESS');
      setTrailer(movieTrailerModel!);
    }
    if (response is Failure) {
      print('GET MOVIE TRAILER Failure');
      MovieError movieError = MovieError(
          code: response.code, massage: response.errorResponse.toString());
      setMovieError(movieError);
      setError(true);
    }
    setLoading(false);
  }

  List shuffle(List items) {
    var random = Random();

    for (var i = items.length - 1; i > 0; i--) {
      var n = random.nextInt(i + 1);

      var temp = items[i];
      items[i] = items[n];
      items[n] = temp;
    }
    return items;
  }
}
