// ignore_for_file: avoid_print

import 'dart:io';

import 'package:flutter_moviedb_api/models/search_model.dart';
import 'package:flutter_moviedb_api/services/api_status.dart';
import 'package:flutter_moviedb_api/utils/constants.dart';
import 'package:http/http.dart' as http;

class SearchService {
  static Future<Object> getSearch(String textSearch) async {
    try {
      var url = Uri.parse(MOVIE_SEARCH + textSearch);
      var response = await http.get(url);
      if (SUCCESS == response.statusCode) {
        return Success(
            code: SUCCESS, response: searchModelFromJson(response.body));
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
