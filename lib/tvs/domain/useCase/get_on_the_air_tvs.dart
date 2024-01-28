import 'package:dartz/dartz.dart';
import 'package:movies/core/usecase/base_usecase.dart';

import 'package:movies/tvs/domain/entities/tvs.dart';
import 'package:movies/tvs/domain/repo/base_tvs_repo.dart';

import '../../../core/error/failure.dart';

class GetOnTheAirTvsUseCase extends BaseUseCase<List<Tvs>, NoParameters> {
  final BaseTvsRepo baseTvsRepo;

  GetOnTheAirTvsUseCase(this.baseTvsRepo);

  @override
  Future<Either<Failure, List<Tvs>>> call(NoParameters parameters) async {
    return await baseTvsRepo.getOnTheAirTvs();
  }
}
