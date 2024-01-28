import 'package:dartz/dartz.dart';
import 'package:movies/core/error/exception.dart';
import 'package:movies/core/error/failure.dart';
import 'package:movies/movies/data/data_source/movie_remote_data_source.dart';
import 'package:movies/movies/domain/entities/movie.dart';
import 'package:movies/movies/domain/entities/movie_detail.dart';
import 'package:movies/movies/domain/entities/recommendations_movie.dart';
import 'package:movies/movies/domain/entities/search_movie.dart';
import 'package:movies/movies/domain/repo/base_movies_repo.dart';
import 'package:movies/movies/domain/useCase/get_movie_details_usecase.dart';
import 'package:movies/movies/domain/useCase/get_recommendations_movie_usecase.dart';
import 'package:movies/movies/domain/useCase/get_search_movie_usecase.dart';

class MoviesRepo implements BaseMoviesRepo {
  final BaseMovieRemoteDataSource baseMovieRemoteDataSource;

  MoviesRepo(this.baseMovieRemoteDataSource);

  @override
  Future<Either<Failure, List<Movie>>> getNowPlayMovie() async {
    final result = await baseMovieRemoteDataSource.getNowPlayingMovie();
    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> getPopularMovie() async {
    final result = await baseMovieRemoteDataSource.getPopularMovie();
    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> getTopRatedMovie() async {
    final result = await baseMovieRemoteDataSource.getTopRatedMovie();
    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, MovieDetail>> getMovieDetails(
      MovieDetailsParameters parameters) async {
    final result = await baseMovieRemoteDataSource.getMovieDetails(parameters);
    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, List<Recommendation>>> getRecommendation(
      RecommendationParameters parameters) async {
    final result =
        await baseMovieRemoteDataSource.getRecommendationsMovie(parameters);
    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, List<SearchMovie>>> fetchSearchMovies(
      SearchMoviesParams params) async {
    final result = await baseMovieRemoteDataSource.getSearchMovie(params);
    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }
}
