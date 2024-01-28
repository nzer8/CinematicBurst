import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:movies/core/usecase/base_usecase.dart';
import 'package:movies/movies/domain/entities/search_movie.dart';

import '../../../core/error/failure.dart';
import '../repo/base_movies_repo.dart';

class SearchMoviesUseCase
    implements BaseUseCase<List<SearchMovie>, SearchMoviesParams> {
  final BaseMoviesRepo baseMoviesRepo;

  SearchMoviesUseCase(this.baseMoviesRepo);

  @override
  Future<Either<Failure, List<SearchMovie>>> call(
      SearchMoviesParams params) async {
    return await baseMoviesRepo.fetchSearchMovies(params);
  }
}

class SearchMoviesParams extends Equatable {
  final String query;

  const SearchMoviesParams({required this.query});

  @override
  List<Object> get props => [query];
}
