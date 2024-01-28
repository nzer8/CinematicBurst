import 'package:dartz/dartz.dart';
import 'package:movies/movies/domain/entities/movie.dart';
import 'package:movies/movies/domain/repo/base_movies_repo.dart';

import '../../../core/error/failure.dart';
import '../../../core/usecase/base_usecase.dart';

class GetTopRatedMovieUseCase extends BaseUseCase<List<Movie>, NoParameters> {
  final BaseMoviesRepo baseMoviesRepo;

  GetTopRatedMovieUseCase(this.baseMoviesRepo);

  @override
  Future<Either<Failure, List<Movie>>> call(NoParameters parameters) async {
    return await baseMoviesRepo.getTopRatedMovie();
  }
}
