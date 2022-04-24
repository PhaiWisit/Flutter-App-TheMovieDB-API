// ignore_for_file: library_prefixes, avoid_print

import 'dart:io';

import 'package:flutter_moviedb_api/models/movie_popular_model.dart' as Popular;
import 'package:flutter_moviedb_api/models/movie_trend_model.dart' as Trend;
import 'package:flutter_moviedb_api/models/movie_trailer_model.dart' as Trailer;
import 'package:flutter_moviedb_api/utils/constants.dart';

import 'api_status.dart';
import 'package:http/http.dart' as http;

class MovieService {
  static Future<Object> getPopular() async {
    try {
      var url = Uri.parse(MOVIE_POPULAR);
      var response = await http.get(url);
      if (SUCCESS == response.statusCode) {
        return Success(
            code: SUCCESS, response: Popular.movieModelFromJson(response.body));
      } else {
        return Failure(
            code: USER_INVALID_RESPONSE, errorResponse: 'Invalid Response');
      }
    } on SocketException {
      return Failure(
          code: NO_INTERNET, errorResponse: 'No Internet Connection');
    } on FormatException {
      return Failure(code: INVALID_FORMAT, errorResponse: 'Invalid Format');
    } catch (e) {
      return Failure(code: UNKNOWN_ERROR, errorResponse: 'Unknown Error');
    }
  }

  static Future<Object> getTrend() async {
    try {
      var url = Uri.parse(MOVIE_TREND);
      var response = await http.get(url);
      if (SUCCESS == response.statusCode) {
        return Success(
            code: SUCCESS,
            response: Trend.movieTrendModelFromJson(response.body));
      } else {
        return Failure(
            code: USER_INVALID_RESPONSE, errorResponse: 'Invalid Response');
      }
    } on SocketException {
      return Failure(
          code: NO_INTERNET, errorResponse: 'No Internet Connection');
    } on FormatException {
      return Failure(code: INVALID_FORMAT, errorResponse: 'Invalid Format');
    } catch (e) {
      print(e);
      return Failure(code: UNKNOWN_ERROR, errorResponse: e);
    }
  }

  static Future<Object> getTrailer() async {
    try {
      var url = Uri.parse(MOVIE_TRAILER);
      var response = await http.get(url);
      if (SUCCESS == response.statusCode) {
        return Success(
            code: SUCCESS,
            response: Trailer.movieTrailerModelFromJson(response.body));
      } else {
        return Failure(
            code: USER_INVALID_RESPONSE, errorResponse: 'Invalid Response');
      }
    } on SocketException {
      return Failure(
          code: NO_INTERNET, errorResponse: 'No Internet Connection');
    } on FormatException {
      return Failure(code: INVALID_FORMAT, errorResponse: 'Invalid Format');
    } catch (e) {
      print(e);
      return Failure(code: UNKNOWN_ERROR, errorResponse: e);
    }
  }
}
