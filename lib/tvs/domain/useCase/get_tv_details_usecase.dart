import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:movies/core/error/failure.dart';
import 'package:movies/core/usecase/base_usecase.dart';
import 'package:movies/tvs/domain/entities/tv_detail.dart';
import 'package:movies/tvs/domain/repo/base_tvs_repo.dart';

class GetTvDetailsUesCase extends BaseUseCase<TvDetails, TvDetailsParameters> {
  final BaseTvsRepo baseTvsRepo;

  GetTvDetailsUesCase(this.baseTvsRepo);

  @override
  Future<Either<Failure, TvDetails>> call(
    TvDetailsParameters parameters,
  ) async {
    return await baseTvsRepo.getTvDetails(parameters);
  }
}

class TvDetailsParameters extends Equatable {
  final int tvId;

  const TvDetailsParameters({required this.tvId});

  @override
  List<Object> get props => [tvId];
}
