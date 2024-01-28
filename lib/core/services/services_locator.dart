import 'package:get_it/get_it.dart';
import 'package:movies/movies/data/data_source/movie_remote_data_source.dart';
import 'package:movies/movies/data/repo/movies_repo.dart';
import 'package:movies/movies/domain/repo/base_movies_repo.dart';
import 'package:movies/movies/domain/useCase/get_movie_details_usecase.dart';
import 'package:movies/movies/domain/useCase/get_now_play_movie_use_case.dart';
import 'package:movies/movies/domain/useCase/get_popular_movie_usecase.dart';
import 'package:movies/movies/domain/useCase/get_recommendations_movie_usecase.dart';
import 'package:movies/movies/domain/useCase/get_search_movie_usecase.dart';
import 'package:movies/movies/domain/useCase/get_top_rated_movie_usecase.dart';
import 'package:movies/movies/presentation/controller/movie_detail_bloc/movie_detail_bloc.dart';
import 'package:movies/movies/presentation/controller/movie/movies_bloc.dart';
import 'package:movies/movies/presentation/controller/search/search_movie_cubit.dart';
import 'package:movies/movies/presentation/controller/see_more_bloc/see_more_bloc.dart';
import 'package:movies/tvs/data/data_source/tvs_remote_data_source.dart';
import 'package:movies/tvs/data/repo/tvs_repo.dart';
import 'package:movies/tvs/domain/repo/base_tvs_repo.dart';
import 'package:movies/tvs/domain/useCase/get_on_the_air_tvs.dart';
import 'package:movies/tvs/domain/useCase/get_popular_tvs.dart';
import 'package:movies/tvs/domain/useCase/get_search_tv_usecase.dart';
import 'package:movies/tvs/domain/useCase/get_top_rated_tvs.dart';
import 'package:movies/tvs/domain/useCase/get_tv_details_usecase.dart';
import 'package:movies/tvs/presentation/controller/search_tv/search_tv_cubit.dart';
import 'package:movies/tvs/presentation/controller/see_more_tv_bloc/see_more_tv_bloc.dart';
import 'package:movies/tvs/presentation/controller/tv_details_bloc/tv_detail_bloc.dart';
import 'package:movies/tvs/presentation/controller/tvs/tvs_bloc.dart';

import '../../tvs/domain/useCase/get_recommendations_tv_usecase.dart';

final getIt = GetIt.instance;

class ServicesLocator {
  void init() {
    /// todo Movie Bloc
    getIt.registerFactory(
      () => MoviesBloc(
        getIt(),
        getIt(),
        getIt(),
      ),
    ); // هي مشان كل ما نادي عل اوبجيكت يجبلي داتا جديدة ومت يتقيد بنفس الداتا كل مرة
    //new object يعني كل ما فوت عل الصفحة يعمل
    getIt.registerFactory(
      () => MovieDetailBloc(
        getIt(),
        getIt(),
      ),
    );
    getIt.registerFactory(
      () => SeeMoreBloc(
        getIt(),
        getIt(),
      ),
    );
    getIt.registerFactory(
      () => SearchMovieCubit(
        getIt(),
      ),
    );

    //------------
    ///todo tv bloc
    getIt.registerFactory(
      () => TvsBloc(
        getIt(),
        getIt(),
        getIt(),
      ),
    );
    getIt.registerFactory(
      () => TvDetailBloc(
        getIt(),
        getIt(),
      ),
    );
    getIt.registerFactory(
      () => SeeMoreTvBloc(
        getIt(),
        getIt(),
      ),
    );
    getIt.registerFactory(
      () => SearchTvCubit(
        getIt(),
      ),
    );

    ///Todo: Movie Use Case
    getIt.registerLazySingleton(() => GetNowPlayMovieUseCase(getIt()));
    getIt.registerLazySingleton(() => GetPopularMovieUseCase(getIt()));
    getIt.registerLazySingleton(() => GetTopRatedMovieUseCase(getIt()));
    getIt.registerLazySingleton(() => GetMovieDetailsUesCase(getIt()));
    getIt.registerLazySingleton(() => GetRecommendationsMovieUseCase(getIt()));
    getIt.registerLazySingleton(() => SearchMoviesUseCase(getIt()));

    ///Todo: Tv Use Case
    getIt.registerLazySingleton(() => GetOnTheAirTvsUseCase(getIt()));
    getIt.registerLazySingleton(() => GetPopularTvsUseCase(getIt()));
    getIt.registerLazySingleton(() => GetTopRatedTvsUseCase(getIt()));
    getIt.registerLazySingleton(() => GetTvDetailsUesCase(getIt()));
    getIt.registerLazySingleton(() => GetRecommendationsTvUseCase(getIt()));
    getIt.registerLazySingleton(() => SearchTvUseCase(getIt()));

    ///todo Movie Repository
    getIt.registerLazySingleton<BaseMoviesRepo>(() => MoviesRepo(getIt()));

    ///todo Tv Repository
    getIt.registerLazySingleton<BaseTvsRepo>(() => TvsRepo(getIt()));

    ///todo Movie DATE SOURCE
    getIt.registerLazySingleton<BaseMovieRemoteDataSource>(
        () => MovieRemoteDataSource());

    ///todo Tv DATE SOURCE
    getIt.registerLazySingleton<BaseTvsRemoteDataSource>(
        () => TvsRemoteDataSource());
  }
}
