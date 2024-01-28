import 'package:movies/movies/data/models/genres_model.dart';
import 'package:movies/movies/domain/entities/movie_detail.dart';

class MovieDetailModel extends MovieDetail {
  const MovieDetailModel({
    required super.backdropPath,
    required super.id,
    required super.genres,
    required super.overView,
    required super.releaseDate,
    required super.title,
    required super.voteAverage,
    required super.runtime,
  });

  factory MovieDetailModel.fromJson(Map<String, dynamic> json) {
    return MovieDetailModel(
      backdropPath: json['backdrop_path'] ?? '',
      id: json['id'],
      genres: List<GenresModel>.from(
        json['genres'].map(
          (x) => GenresModel.fromJson(x),
        ),
      ),
      overView: json['overview'],
      releaseDate: json['release_date'],
      title: json['title'],
      voteAverage: json['vote_average'].toDouble(),
      runtime: json['runtime'].toDouble(),
    );
  }
}
