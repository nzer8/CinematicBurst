import 'package:dartz/dartz.dart';
import 'package:movies/core/usecase/base_usecase.dart';
import 'package:movies/movies/domain/entities/movie.dart';
import 'package:movies/movies/domain/repo/base_movies_repo.dart';

import '../../../core/error/failure.dart';

class GetNowPlayMovieUseCase extends BaseUseCase<List<Movie>, NoParameters> {
  final BaseMoviesRepo baseMoviesRepo;

  GetNowPlayMovieUseCase(this.baseMoviesRepo);

  @override
  Future<Either<Failure, List<Movie>>> call(NoParameters parameters) async {
    return await baseMoviesRepo.getNowPlayMovie();
  }
}
