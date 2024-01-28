import 'package:movies/movies/domain/entities/genres.dart';
import 'package:movies/tvs/domain/entities/genres_tv.dart';

class TvGenresModel extends GenresTv {
  const TvGenresModel({
    required super.id,
    required super.name,
  });
  factory TvGenresModel.fromJson(Map<String, dynamic> json) {
    return TvGenresModel(
      id: json['id'],
      name: json['name'],
    );
  }
}
