import 'package:dio/dio.dart';
import 'package:movies/tvs/data/models/search_tv_model.dart';
import 'package:movies/tvs/data/models/tv_model_detail.dart';
import 'package:movies/tvs/data/models/tv_recommendation_model.dart';
import 'package:movies/tvs/data/models/tvs_model.dart';
import 'package:movies/tvs/domain/useCase/get_search_tv_usecase.dart';
import 'package:movies/tvs/domain/useCase/get_tv_details_usecase.dart';

import '../../../core/error/exception.dart';
import '../../../core/network/api_constance.dart';
import '../../../core/network/error_message_model.dart';
import '../../domain/useCase/get_recommendations_tv_usecase.dart';

abstract class BaseTvsRemoteDataSource {
  Future<List<TvsModel>> getOnTheAirTvs();

  Future<List<TvsModel>> getPopularTvs();

  Future<List<TvsModel>> getTopRatedTvs();
  Future<TvModelDetail> getTvDetails(TvDetailsParameters parameters);
  Future<List<TvRecommendationModel>> getTvRecommendations(
      TvRecommendationParameters parameters);
  Future<List<SearchTvModel>> getSearchTv(SearchTvsParams params);
}

class TvsRemoteDataSource extends BaseTvsRemoteDataSource {
  @override
  Future<List<TvsModel>> getOnTheAirTvs() async {
    var response = await Dio().get(ApiConstance.onTheAir);
    if (response.statusCode == 200) {
      return List<TvsModel>.from(
          (response.data["results"] as List).map((e) => TvsModel.fromJson(e)));
    } else {
      throw ServerException(
        errorMessageModel: ErrorMessageModel.fromJson(response.data),
      );
    }
  }

  @override
  Future<List<TvsModel>> getPopularTvs() async {
    var response = await Dio().get(ApiConstance.popularTvPath);
    if (response.statusCode == 200) {
      return List<TvsModel>.from(
          (response.data["results"] as List).map((e) => TvsModel.fromJson(e)));
    } else {
      throw ServerException(
        errorMessageModel: ErrorMessageModel.fromJson(response.data),
      );
    }
  }

  @override
  Future<List<TvsModel>> getTopRatedTvs() async {
    var response = await Dio().get(ApiConstance.topRatedTvPath);
    if (response.statusCode == 200) {
      return List<TvsModel>.from(
          (response.data["results"] as List).map((e) => TvsModel.fromJson(e)));
    } else {
      throw ServerException(
        errorMessageModel: ErrorMessageModel.fromJson(response.data),
      );
    }
  }

  @override
  Future<TvModelDetail> getTvDetails(TvDetailsParameters parameters) async {
    var response = await Dio().get(ApiConstance.tvDetailsPath(parameters.tvId));
    if (response.statusCode == 200) {
      return TvModelDetail.fromJson(response.data);
    } else {
      throw ServerException(
          errorMessageModel: ErrorMessageModel.fromJson(response.data));
    }
  }

  @override
  Future<List<TvRecommendationModel>> getTvRecommendations(
      TvRecommendationParameters parameters) async {
    final response =
        await Dio().get(ApiConstance.recommendationTvPath(parameters.tvId));

    if (response.statusCode == 200) {
      return List<TvRecommendationModel>.from((response.data["results"] as List)
          .map((e) => TvRecommendationModel.fromJson(e)));
    } else {
      throw ServerException(
          errorMessageModel: ErrorMessageModel.fromJson(response.data));
    }
  }

  @override
  Future<List<SearchTvModel>> getSearchTv(
    SearchTvsParams params,
  ) async {
    final dio = Dio();

    // Encode the query parameter to ensure it is URL-safe
    final encodedQuery = Uri.encodeQueryComponent(params.query);

    final response = await dio.get(
      'https://api.themoviedb.org/3/search/tv?query=$encodedQuery&include_adult=false',
      options: Options(
        headers: {
          'Authorization':
              'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIwMjQ3YTI1YzgwZTM2YjUzZGI0YmFmNTFjYjcxMzc3MiIsInN1YiI6IjY1MjE4MzVlMGNiMzM1MTZmODdkZWVjZSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.X637FiQD3vO3DLvU2Jbvkn5lF3-nkTc7jXOxnSlBqyY',
          'accept': 'application/json',
        },
      ),
    );

    if (response.statusCode == 200) {
      return List<SearchTvModel>.from(
        (response.data["results"] as List)
            .map((e) => SearchTvModel.fromJson(e)),
      );
    } else {
      throw ServerException(
        errorMessageModel: ErrorMessageModel.fromJson(response.data),
      );
    }
  }
}
