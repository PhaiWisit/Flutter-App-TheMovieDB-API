import 'dart:io';

import 'package:flutter_moviedb_api/models/movie_video_model.dart';
import 'package:flutter_moviedb_api/utils/constants.dart';
import 'api_status.dart';
import 'package:http/http.dart' as http;

class DetailService {
  static Future<Object> getVideo(int movieId) async {
    try {
      var url = Uri.parse(MOVIE_VIDEO_1 + movieId.toString() + MOVIE_VIDEO_2);
      var response = await http.get(url);
      if (SUCCESS == response.statusCode) {
        return Success(
            code: SUCCESS, response: movieVideoModelFromJson(response.body));
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
      return Failure(code: UNKNOWN_ERROR, errorResponse: e);
    }
  }

  static Future<Object> getVideoTv(int movieId) async {
    try {
      var url = Uri.parse(TV_VIDEO_1 + movieId.toString() + TV_VIDEO_2);
      var response = await http.get(url);
      if (SUCCESS == response.statusCode) {
        return Success(
            code: SUCCESS, response: movieVideoModelFromJson(response.body));
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
      return Failure(code: UNKNOWN_ERROR, errorResponse: e);
    }
  }
}
