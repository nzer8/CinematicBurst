import 'package:dartz/dartz.dart';
import 'package:movies/tvs/domain/entities/search_tv.dart';
import 'package:movies/tvs/domain/entities/tv_detail.dart';
import 'package:movies/tvs/domain/entities/tvs.dart';

import '../../../core/error/failure.dart';
import '../entities/recommendation_tvs.dart';
import '../useCase/get_recommendations_tv_usecase.dart';
import '../useCase/get_search_tv_usecase.dart';
import '../useCase/get_tv_details_usecase.dart';

abstract class BaseTvsRepo {
  Future<Either<Failure, List<Tvs>>> getOnTheAirTvs();
  Future<Either<Failure, List<Tvs>>> getPopularTvs();
  Future<Either<Failure, List<Tvs>>> getTopRatedTvs();
  Future<Either<Failure, TvDetails>> getTvDetails(
    TvDetailsParameters parameters,
  );

  Future<Either<Failure, List<RecommendationTvs>>> getRecommendationTv(
      TvRecommendationParameters parameters);

  Future<Either<Failure, List<SearchTvs>>> fetchSearchTv(
      SearchTvsParams params);
}
