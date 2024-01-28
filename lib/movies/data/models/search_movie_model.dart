import 'package:movies/movies/domain/entities/search_movie.dart';

class SearchMovieModel extends SearchMovie {
  const SearchMovieModel({
    required super.id,
    required super.backdropPath,
    required super.overView,
    required super.title,
  });

  factory SearchMovieModel.fromJson(Map<String, dynamic> json) =>
      SearchMovieModel(
        id: json["id"],
        backdropPath: json["backdrop_path"] ?? '',
        overView: json['overview'],
        title: json['title'],
      );
}
