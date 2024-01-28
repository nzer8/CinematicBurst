import 'package:movies/tvs/domain/entities/search_tv.dart';

class SearchTvModel extends SearchTvs {
  const SearchTvModel({
    required super.id,
    required super.backdropPath,
    required super.overView,
    required super.name,
  });

  factory SearchTvModel.fromJson(Map<String, dynamic> json) => SearchTvModel(
        id: json["id"],
        backdropPath: json["backdrop_path"] ?? '',
        overView: json['overview'],
        name: json['name'],
      );
}
