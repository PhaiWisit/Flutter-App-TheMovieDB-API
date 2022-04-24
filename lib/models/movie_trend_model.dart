// To parse this JSON data, do
//
//     final movieTrendModel = movieTrendModelFromJson(jsonString);

// ignore_for_file: constant_identifier_names

import 'dart:convert';

MovieTrendModel movieTrendModelFromJson(String str) =>
    MovieTrendModel.fromJson(json.decode(str));

String movieTrendModelToJson(MovieTrendModel data) =>
    json.encode(data.toJson());

class MovieTrendModel {
  MovieTrendModel({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  int page;
  List<Result> results;
  int totalPages;
  int totalResults;

  factory MovieTrendModel.fromJson(Map<String, dynamic> json) =>
      MovieTrendModel(
        page: json["page"],
        results:
            List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
        "total_pages": totalPages,
        "total_results": totalResults,
      };
}

class Result {
  Result({
    this.originalLanguage,
    required this.originalTitle,
    required this.posterPath,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.overview,
    this.releaseDate,
    required this.adult,
    required this.backdropPath,
    required this.id,
    required this.genreIds,
    required this.voteCount,
    required this.popularity,
    this.mediaType,
    this.originCountry,
    required this.name,
    this.firstAirDate,
    required this.originalName,
  });

  OriginalLanguage? originalLanguage;
  String originalTitle;
  String posterPath;
  String title;
  bool video;
  double voteAverage;
  String overview;
  DateTime? releaseDate;
  bool adult;
  String backdropPath;
  int id;
  List<int> genreIds;
  int voteCount;
  double popularity;
  MediaType? mediaType;
  List<String>? originCountry;
  String name;
  DateTime? firstAirDate;
  String originalName;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        originalLanguage: originalLanguageValues.map[json["original_language"]],
        originalTitle: json["original_title"] ?? 'null',
        posterPath: json["poster_path"],
        title: json["title"] ?? 'null',
        video: json["video"] ?? false,
        voteAverage: json["vote_average"].toDouble(),
        overview: json["overview"],
        releaseDate: json["release_date"] == null
            ? null
            : DateTime.parse(json["release_date"]),
        adult: json["adult"] ?? false,
        backdropPath: json["backdrop_path"],
        id: json["id"],
        genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
        voteCount: json["vote_count"],
        popularity: json["popularity"].toDouble(),
        mediaType: mediaTypeValues.map[json["media_type"]],
        originCountry: json["origin_country"] == null
            ? ['']
            : List<String>.from(json["origin_country"].map((x) => x)),
        name: json["name"] ?? 'null',
        firstAirDate: json["first_air_date"] == null
            ? DateTime.now()
            : DateTime.parse(json["first_air_date"]),
        originalName: json["original_name"] ?? 'null',
      );

  Map<String, dynamic> toJson() => {
        "original_language": originalLanguageValues.reverse[originalLanguage],
        "original_title": originalTitle,
        "poster_path": posterPath,
        "title": title,
        "video": video,
        "vote_average": voteAverage,
        "overview": overview,
        "release_date": releaseDate == null
            ? null
            : "${releaseDate!.year.toString().padLeft(4, '0')}-${releaseDate!.month.toString().padLeft(2, '0')}-${releaseDate!.day.toString().padLeft(2, '0')}",
        "adult": adult,
        "backdrop_path": backdropPath,
        "id": id,
        "genre_ids": List<dynamic>.from(genreIds.map((x) => x)),
        "vote_count": voteCount,
        "popularity": popularity,
        "media_type": mediaTypeValues.reverse[mediaType],
        "origin_country": originCountry == null
            ? null
            : List<dynamic>.from(originCountry!.map((x) => x)),
        "name": name,
        "first_air_date": firstAirDate == null
            ? null
            : "${firstAirDate!.year.toString().padLeft(4, '0')}-${firstAirDate!.month.toString().padLeft(2, '0')}-${firstAirDate!.day.toString().padLeft(2, '0')}",
        "original_name": originalName,
      };
}

enum MediaType { MOVIE, TV }

final mediaTypeValues =
    EnumValues({"movie": MediaType.MOVIE, "tv": MediaType.TV});

enum OriginalLanguage { EN, ES }

final originalLanguageValues =
    EnumValues({"en": OriginalLanguage.EN, "es": OriginalLanguage.ES});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    // if (reverseMap == null) {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    // }
    return reverseMap!;
  }
}
