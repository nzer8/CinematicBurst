import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:movies/core/error/failure.dart';
import 'package:movies/core/usecase/base_usecase.dart';

import 'package:movies/tvs/domain/entities/recommendation_tvs.dart';
import 'package:movies/tvs/domain/repo/base_tvs_repo.dart';

class GetRecommendationsTvUseCase
    extends BaseUseCase<List<RecommendationTvs>, TvRecommendationParameters> {
  final BaseTvsRepo baseTvRepo;

  GetRecommendationsTvUseCase(this.baseTvRepo);

  @override
  Future<Either<Failure, List<RecommendationTvs>>> call(
      TvRecommendationParameters parameters) async {
    return await baseTvRepo.getRecommendationTv(parameters);
  }
}

class TvRecommendationParameters extends Equatable {
  final int tvId;

  const TvRecommendationParameters({required this.tvId});

  @override
  List<Object> get props => [tvId];
}
