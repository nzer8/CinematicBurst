import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:movies/core/usecase/base_usecase.dart';
import 'package:movies/tvs/domain/entities/search_tv.dart';
import 'package:movies/tvs/domain/repo/base_tvs_repo.dart';

import '../../../core/error/failure.dart';

class SearchTvUseCase implements BaseUseCase<List<SearchTvs>, SearchTvsParams> {
  final BaseTvsRepo baseTvsRepo;

  SearchTvUseCase(this.baseTvsRepo);

  @override
  Future<Either<Failure, List<SearchTvs>>> call(SearchTvsParams params) async {
    return await baseTvsRepo.fetchSearchTv(params);
  }
}

class SearchTvsParams extends Equatable {
  final String query;

  const SearchTvsParams({required this.query});

  @override
  List<Object> get props => [query];
}
