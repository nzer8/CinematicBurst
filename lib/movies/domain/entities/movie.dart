import 'package:equatable/equatable.dart';

class Movie extends Equatable {
  final int id;
  final String backdropPath;
  final String title;
  final String overView;
  final List<int> genreIds;
  final double voteAverage;
  final String releaseDate;

  const Movie({
    required this.id,
    required this.backdropPath,
    required this.title,
    required this.overView,
    required this.genreIds,
    required this.voteAverage,
    required this.releaseDate,
  });

  @override
  List<Object> get props => [
        id,
        backdropPath,
        title,
        overView,
        genreIds,
        voteAverage,
        releaseDate,
      ];
}
