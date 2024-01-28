import 'package:equatable/equatable.dart';

class Tvs extends Equatable {
  final int id;
  final String backdropPath;
  final String name;
  final String overView;
  final List<int> genreIds;
  final double voteAverage;
  final String firstAirDate;

  const Tvs({
    required this.id,
    required this.backdropPath,
    required this.name,
    required this.overView,
    required this.genreIds,
    required this.voteAverage,
    required this.firstAirDate,
  });

  @override
  List<Object> get props => [
        id,
        backdropPath,
        name,
        overView,
        genreIds,
        voteAverage,
        firstAirDate,
      ];
}
