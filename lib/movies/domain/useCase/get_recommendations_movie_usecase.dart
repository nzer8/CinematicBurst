import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:movies/core/error/failure.dart';
import 'package:movies/core/usecase/base_usecase.dart';
import 'package:movies/movies/domain/entities/recommendations_movie.dart';
import 'package:movies/movies/domain/repo/base_movies_repo.dart';

class GetRecommendationsMovieUseCase
    extends BaseUseCase<List<Recommendation>, RecommendationParameters> {
  final BaseMoviesRepo baseMoviesRepo;

  GetRecommendationsMovieUseCase(this.baseMoviesRepo);

  @override
  Future<Either<Failure, List<Recommendation>>> call(
      RecommendationParameters parameters) async {
    return await baseMoviesRepo.getRecommendation(parameters);
  }
}

class RecommendationParameters extends Equatable {
  final int movieId;

  const RecommendationParameters({required this.movieId});

  @override
  List<Object> get props => [movieId];
}
