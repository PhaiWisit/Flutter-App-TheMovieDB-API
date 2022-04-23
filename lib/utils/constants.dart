// ignore_for_file: constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:flutter_moviedb_api/utils/api_key.dart';

const String MOVIE_POPULAR =
    'https://api.themoviedb.org/3/movie/popular?api_key=' +
        MOVIE_API_KEY +
        '&language=en-US&page=1';

const String VIEW_MOVIE_IMAGE = 'https://image.tmdb.org/t/p/w500/';
const String VIEW_MOVIE_YOUTUBE = 'https://www.youtube.com/watch?v=';

//Color
const Color colorBlueDark = Color(0xFF101010);

//Status
const SUCCESS = 200;
const USER_INVALID_RESPONSE = 100;
const NO_INTERNET = 101;
const INVALID_FORMAT = 102;
const UNKNOWN_ERROR = 103;
