import 'package:movies/tvs/domain/entities/tvs.dart';

class TvsModel extends Tvs {
  const TvsModel({
    required super.id,
    required super.backdropPath,
    required super.name,
    required super.overView,
    required super.genreIds,
    required super.voteAverage,
    required super.firstAirDate,
  });

  factory TvsModel.fromJson(Map<String, dynamic> json) {
    return TvsModel(
      id: json["id"],
      backdropPath: json['backdrop_path'] ?? '',
      name: json['name'],
      overView: json['overview'],
      genreIds: List<int>.from(json["genre_ids"].map((e) => e)),
      voteAverage: json['vote_average'],
      firstAirDate: json['first_air_date'],
    );
  }
}
