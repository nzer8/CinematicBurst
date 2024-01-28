import 'package:movies/tvs/data/models/tv_genres_model.dart';
import 'package:movies/tvs/domain/entities/tv_detail.dart';

class TvModelDetail extends TvDetails {
  const TvModelDetail({
    required super.id,
    required super.backdropPath,
    required super.overView,
    required super.name,
    required super.voteAverage,
    required super.firstAirDate,
    required super.numberOfSeasons,
    required super.genres,
  });

  factory TvModelDetail.fromJson(Map<String, dynamic> json) {
    return TvModelDetail(
      id: json['id'],
      backdropPath: json['backdrop_path'] ?? '',
      overView: json['overview'],
      name: json['name'],
      voteAverage: json['vote_average'].toDouble(),
      firstAirDate: json['first_air_date'],
      numberOfSeasons: json['number_of_seasons'],
      genres: List<TvGenresModel>.from(
        json['genres'].map(
          (x) => TvGenresModel.fromJson(x),
        ),
      ),
    );
  }
}
