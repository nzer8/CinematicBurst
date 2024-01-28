import 'package:equatable/equatable.dart';
import 'package:movies/movies/domain/entities/genres.dart';

class MovieDetail extends Equatable {
  final String backdropPath;
  final int id;
  final List<Genres> genres;
  final String overView;
  final String releaseDate;
  final String title;
  final double voteAverage;
  final double runtime;

  const MovieDetail({
    required this.backdropPath,
    required this.id,
    required this.genres,
    required this.overView,
    required this.releaseDate,
    required this.title,
    required this.voteAverage,
    required this.runtime,
  });

  @override
  List<Object> get props => [
        backdropPath,
        id,
        genres,
        overView,
        releaseDate,
        title,
        voteAverage,
        runtime,
      ];
}
