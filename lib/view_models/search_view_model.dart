import 'package:flutter/foundation.dart';
import 'package:flutter_moviedb_api/models/movie_error.dart';
import 'package:flutter_moviedb_api/models/search_model.dart';
import 'package:flutter_moviedb_api/services/api_status.dart';
import 'package:flutter_moviedb_api/services/search_service.dart';

class SearchViewModel extends ChangeNotifier {
  bool _loading = false;
  bool _error = false;
  SearchModel? _searchModel;
  List<Result> _searchList = [];
  MovieError _movieError = MovieError(code: 0, massage: 'massage');

  bool get loading => _loading;
  bool get error => _error;
  SearchModel? get searchModel => _searchModel;
  List<Result> get searchList => _searchList;
  MovieError get movieError => _movieError;

  SearchViewModel() {
    // getSearch();
  }

  setSearchModel(SearchModel searchModel) {
    _searchModel = searchModel;
  }

  setError(bool error) {
    _error = error;
  }

  setLoading(bool loading) {
    _loading = loading;
    notifyListeners();
  }

  setMovieError(MovieError movieError) {
    _movieError = movieError;
  }

  setSearchList(SearchModel searchModel) {
    _searchList = [];
    int resLength = searchModel.results.length;
    for (int i = 0; i < resLength; i++) {
      _searchList.add(searchModel.results[i]);
    }
  }

  clearSearchList() async {
    _searchList = [];
    notifyListeners();
  }

  getSearch(String textSearch) async {
    setLoading(true);
    var response = await SearchService.getSearch(textSearch);
    if (response is Success) {
      await setSearchModel(response.response as SearchModel);
      print('GET MOVIE SEARCH SUCCESS');

      setSearchList(_searchModel!);
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
