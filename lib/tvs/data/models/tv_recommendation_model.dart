import '../../domain/entities/recommendation_tvs.dart';

class TvRecommendationModel extends RecommendationTvs {
  const TvRecommendationModel({
    super.backdropPath,
    required super.id,
  });

  factory TvRecommendationModel.fromJson(Map<String, dynamic> json) =>
      TvRecommendationModel(
        id: json["id"],
        backdropPath: json["backdrop_path"] ?? '',
      );
}
