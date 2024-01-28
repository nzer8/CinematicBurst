import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:movies/core/error/failure.dart';
import 'package:movies/core/usecase/base_usecase.dart';
import 'package:movies/movies/domain/entities/movie_detail.dart';

import '../repo/base_movies_repo.dart';

class GetMovieDetailsUesCase
    extends BaseUseCase<MovieDetail, MovieDetailsParameters> {
  final BaseMoviesRepo baseMoviesRepo;

  GetMovieDetailsUesCase(this.baseMoviesRepo);

  @override
  Future<Either<Failure, MovieDetail>> call(
    MovieDetailsParameters parameters,
  ) async {
    return await baseMoviesRepo.getMovieDetails(parameters);
  }
}

class MovieDetailsParameters extends Equatable {
  final int movieId;

  const MovieDetailsParameters({required this.movieId});

  @override
  List<Object> get props => [movieId];
}
