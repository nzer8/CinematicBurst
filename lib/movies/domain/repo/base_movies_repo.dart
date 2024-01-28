import 'package:dartz/dartz.dart';
import 'package:movies/movies/domain/entities/movie_detail.dart';
import 'package:movies/movies/domain/entities/recommendations_movie.dart';
import 'package:movies/movies/domain/entities/search_movie.dart';
import 'package:movies/movies/domain/useCase/get_movie_details_usecase.dart';
import 'package:movies/movies/domain/useCase/get_search_movie_usecase.dart';

import '../../../core/error/failure.dart';
import '../entities/movie.dart';
import '../useCase/get_recommendations_movie_usecase.dart';

abstract class BaseMoviesRepo {
  Future<Either<Failure, List<Movie>>> getNowPlayMovie();
  Future<Either<Failure, List<Movie>>> getPopularMovie();
  Future<Either<Failure, List<Movie>>> getTopRatedMovie();

  Future<Either<Failure, MovieDetail>> getMovieDetails(
    MovieDetailsParameters parameters,
  );
  Future<Either<Failure, List<Recommendation>>> getRecommendation(
      RecommendationParameters parameters);

  Future<Either<Failure, List<SearchMovie>>> fetchSearchMovies(
      SearchMoviesParams params);
}
