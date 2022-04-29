import 'package:flutter/foundation.dart';
import 'package:flutter_moviedb_api/models/movie_error.dart';
import 'package:flutter_moviedb_api/services/api_status.dart';
import 'package:flutter_moviedb_api/services/detail_service.dart';
import 'package:flutter_moviedb_api/view_models/main_view_model.dart';
import '../models/movie_video_model.dart';
import 'package:provider/provider.dart';

class DetailViewModel extends ChangeNotifier {
  bool _notNull = false;
  bool _loading = false;
  bool _error = false;
  MovieError _movieError = MovieError(code: 0, massage: 'massage');
  MovieVideoModel? _movieVideoModel;

  bool get notNull => _notNull;
  bool get loading => _loading;
  bool get error => _error;
  MovieError get movieError => _movieError;
  MovieVideoModel get movieVideoModel => _movieVideoModel!;

  setNotNull(bool notNull) {
    _notNull = notNull;
    notifyListeners();
  }

  setLoading(bool loading) {
    _loading = loading;
    notifyListeners();
  }

  setError(bool errer) {
    _error = errer;
    notifyListeners();
  }

  setMovieError(MovieError movieError) {
    _movieError = movieError;
  }

  setMovieVideoModel(MovieVideoModel movieVideoModel) {
    _movieVideoModel = movieVideoModel;

    // for (int i = 0; i < movieVideoModel.results.length; i++) {
    //   print(movieVideoModel.results[i].name);
    // }
  }

  clearMovieVideoModel() {
    _movieVideoModel == null;
  }

  getMovieVideo(int movieId, String mediaType) async {
    setLoading(true);

    if (mediaType == 'MediaType.MOVIE') {
      var response = await DetailService.getVideo(movieId);
      if (response is Success) {
        await setMovieVideoModel(response.response as MovieVideoModel);
        print('GET MOVIE VIDEO SUCCESS');
      }
      if (response is Failure) {
        MovieError movieError = MovieError(
            code: response.code, massage: response.errorResponse.toString());
        print('Failure');
        setMovieError(movieError);
        setError(true);
      }
    } else {
      var response = await DetailService.getVideoTv(movieId);
      if (response is Success) {
        await setMovieVideoModel(response.response as MovieVideoModel);
        print('GET MOVIE VIDEO SUCCESS');
      }
      if (response is Failure) {
        MovieError movieError = MovieError(
            code: response.code, massage: response.errorResponse.toString());
        print('Failure');
        setMovieError(movieError);
        setError(true);
      }
    }

    setLoading(false);
  }
}
