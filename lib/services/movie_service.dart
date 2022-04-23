import 'dart:io';

import 'package:flutter_moviedb_api/models/movie_model.dart';
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
            code: SUCCESS, response: movieModelFromJson(response.body));
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

    // var request = http.Request(
    //     'GET',
    //     Uri.parse(
    //         'https://api.themoviedb.org/3/movie/popular?api_key=6e87fd216de01af5e84bd54deb5c8999&language=en-US&page=1'));

    // http.StreamedResponse response = await request.send();

    // if (response.statusCode == 200) {
    //   print(await response.stream.bytesToString());
    // } else {
    //   print(response.reasonPhrase);
    // }
  }
}
