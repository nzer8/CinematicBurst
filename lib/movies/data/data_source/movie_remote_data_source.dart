import 'package:dio/dio.dart';
import 'package:movies/core/error/exception.dart';
import 'package:movies/core/network/api_constance.dart';
import 'package:movies/core/network/error_message_model.dart';
import 'package:movies/movies/data/models/movie_detail_model.dart';
import 'package:movies/movies/data/models/movie_model.dart';
import 'package:movies/movies/data/models/recommendations_model.dart';
import 'package:movies/movies/data/models/search_movie_model.dart';
import 'package:movies/movies/domain/useCase/get_movie_details_usecase.dart';
import 'package:movies/movies/domain/useCase/get_search_movie_usecase.dart';

import '../../domain/useCase/get_recommendations_movie_usecase.dart';

abstract class BaseMovieRemoteDataSource {
  // from  useCases

  Future<List<MovieModel>> getNowPlayingMovie();

  Future<List<MovieModel>> getPopularMovie();

  Future<List<MovieModel>> getTopRatedMovie();

  Future<MovieDetailModel> getMovieDetails(MovieDetailsParameters parameters);

  Future<List<RecommendationModel>> getRecommendationsMovie(
      RecommendationParameters parameters);

  Future<List<SearchMovieModel>> getSearchMovie(SearchMoviesParams params);
}

class MovieRemoteDataSource extends BaseMovieRemoteDataSource {
  @override
  Future<List<MovieModel>> getNowPlayingMovie() async {
    var response = await Dio().get(ApiConstance.nowPlayingMoviePath);
    if (response.statusCode == 200) {
      return List<MovieModel>.from((response.data["results"] as List)
          .map((e) => MovieModel.fromJson(e)));
    } else {
      throw ServerException(
        errorMessageModel: ErrorMessageModel.fromJson(response.data),
      );
    }
  }

  @override
  Future<List<MovieModel>> getPopularMovie() async {
    var response = await Dio().get(ApiConstance.popularMoviePath);
    if (response.statusCode == 200) {
      return List<MovieModel>.from((response.data["results"] as List)
          .map((e) => MovieModel.fromJson(e)));
    } else {
      throw ServerException(
        errorMessageModel: ErrorMessageModel.fromJson(response.data),
      );
    }
  }

  @override
  Future<List<MovieModel>> getTopRatedMovie() async {
    var response = await Dio().get(ApiConstance.topRatedMoviePath);
    if (response.statusCode == 200) {
      return List<MovieModel>.from((response.data["results"] as List)
          .map((e) => MovieModel.fromJson(e)));
    } else {
      throw ServerException(
        errorMessageModel: ErrorMessageModel.fromJson(response.data),
      );
    }
  }

  @override
  Future<MovieDetailModel> getMovieDetails(
      MovieDetailsParameters parameters) async {
    var response =
        await Dio().get(ApiConstance.movieDetailsPath(parameters.movieId));
    if (response.statusCode == 200) {
      return MovieDetailModel.fromJson(response.data);
    } else {
      throw ServerException(
          errorMessageModel: ErrorMessageModel.fromJson(response.data));
    }
  }

  @override
  Future<List<RecommendationModel>> getRecommendationsMovie(
      RecommendationParameters parameters) async {
    final response =
        await Dio().get(ApiConstance.recommendationPath(parameters.movieId));

    if (response.statusCode == 200) {
      return List<RecommendationModel>.from((response.data["results"] as List)
          .map((e) => RecommendationModel.fromJson(e)));
    } else {
      throw ServerException(
          errorMessageModel: ErrorMessageModel.fromJson(response.data));
    }
  }

  @override
  Future<List<SearchMovieModel>> getSearchMovie(
    SearchMoviesParams params,
  ) async {
    final dio = Dio();

    // Encode the query parameter to ensure it is URL-safe
    final encodedQuery = Uri.encodeQueryComponent(params.query);

    final response = await dio.get(
      'https://api.themoviedb.org/3/search/movie?query=$encodedQuery&include_adult=false&language=en-US&page=1',
      options: Options(
        headers: {
          'Authorization':
              'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIwMjQ3YTI1YzgwZTM2YjUzZGI0YmFmNTFjYjcxMzc3MiIsInN1YiI6IjY1MjE4MzVlMGNiMzM1MTZmODdkZWVjZSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.X637FiQD3vO3DLvU2Jbvkn5lF3-nkTc7jXOxnSlBqyY',
          'accept': 'application/json',
        },
      ),
    );

    if (response.statusCode == 200) {
      return List<SearchMovieModel>.from(
        (response.data["results"] as List)
            .map((e) => SearchMovieModel.fromJson(e)),
      );
    } else {
      throw ServerException(
        errorMessageModel: ErrorMessageModel.fromJson(response.data),
      );
    }
  }
}
