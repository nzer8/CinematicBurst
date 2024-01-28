import 'package:equatable/equatable.dart';

import 'genres_tv.dart';

class TvDetails extends Equatable {
  final int id;
  final String backdropPath;
  final String overView;
  final String name;
  final double voteAverage;
  final String firstAirDate;
  final int numberOfSeasons;
  final List<GenresTv> genres;

  const TvDetails({
    required this.id,
    required this.backdropPath,
    required this.overView,
    required this.name,
    required this.voteAverage,
    required this.firstAirDate,
    required this.numberOfSeasons,
    required this.genres,
  });

  @override
  List<Object> get props => [
        id,
        backdropPath,
        overView,
        name,
        voteAverage,
        firstAirDate,
        numberOfSeasons,
        genres,
      ];
}
