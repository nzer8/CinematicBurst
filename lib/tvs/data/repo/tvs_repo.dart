import 'package:dartz/dartz.dart';
import 'package:movies/core/error/failure.dart';
import 'package:movies/tvs/data/data_source/tvs_remote_data_source.dart';
import 'package:movies/tvs/domain/entities/recommendation_tvs.dart';
import 'package:movies/tvs/domain/entities/search_tv.dart';
import 'package:movies/tvs/domain/entities/tv_detail.dart';
import 'package:movies/tvs/domain/entities/tvs.dart';
import 'package:movies/tvs/domain/repo/base_tvs_repo.dart';
import 'package:movies/tvs/domain/useCase/get_recommendations_tv_usecase.dart';
import 'package:movies/tvs/domain/useCase/get_search_tv_usecase.dart';
import 'package:movies/tvs/domain/useCase/get_tv_details_usecase.dart';

import '../../../core/error/exception.dart';

class TvsRepo extends BaseTvsRepo {
  final BaseTvsRemoteDataSource baseTvsRemoteDataSource;

  TvsRepo(this.baseTvsRemoteDataSource);

  @override
  Future<Either<Failure, List<Tvs>>> getOnTheAirTvs() async {
    final result = await baseTvsRemoteDataSource.getOnTheAirTvs();
    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, List<Tvs>>> getPopularTvs() async {
    final result = await baseTvsRemoteDataSource.getPopularTvs();
    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, List<Tvs>>> getTopRatedTvs() async {
    final result = await baseTvsRemoteDataSource.getTopRatedTvs();
    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, TvDetails>> getTvDetails(
      TvDetailsParameters parameters) async {
    final result = await baseTvsRemoteDataSource.getTvDetails(parameters);
    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, List<RecommendationTvs>>> getRecommendationTv(
      TvRecommendationParameters parameters) async {
    final result =
        await baseTvsRemoteDataSource.getTvRecommendations(parameters);
    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, List<SearchTvs>>> fetchSearchTv(
      SearchTvsParams params) async {
    final result = await baseTvsRemoteDataSource.getSearchTv(params);
    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }
}
