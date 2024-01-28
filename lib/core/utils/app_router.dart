import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:movies/core/services/services_locator.dart';
import 'package:movies/home_view.dart';
import 'package:movies/movies/presentation/controller/search/search_movie_cubit.dart';
import 'package:movies/tvs/domain/useCase/get_search_tv_usecase.dart';
import 'package:movies/tvs/presentation/components/see_more_popular_tv.dart';
import 'package:movies/tvs/presentation/components/see_more_top_rated_tv.dart';
import 'package:movies/tvs/presentation/controller/search_tv/search_tv_cubit.dart';
import 'package:movies/tvs/presentation/screens/tv_detail_screen.dart';
import 'package:movies/tvs/presentation/screens/tvs_screen.dart';

import '../../movies/domain/useCase/get_search_movie_usecase.dart';
import '../../movies/presentation/components/see_more_popular_movie.dart';
import '../../movies/presentation/components/see_more_top_rated_movie.dart';
import '../../movies/presentation/screens/movie_detail_screen.dart';
import '../../movies/presentation/screens/movies_screen.dart';
import '../../movies/presentation/screens/search/search_view_movie_body.dart';
import '../../splash/splash_view.dart';
import '../../tvs/presentation/screens/search_tv/search_view_tv_body.dart';

abstract class AppRouter {
  static const kHomeView = '/homeView';
  static const kSearchMovieView = '/searchMovieView';
  static const kSeeMorePopularMovie = '/seeMorePopMovie';
  static const kSeeMorePopularTv = '/seeMorePopTv';
  static const kSeeMoreTopRatedMovie = '/seeMoreTopMovie';
  static const kSeeMoreTopRatedTv = '/seeMoreTopTv';
  static const kSearchTvView = '/searchTvView';
  static const kMainMovieScreen = '/mainMovieScreen';
  static const kMainTvScreen = '/mainTvScreen';

  static final router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const SplashView(),
      ),
      GoRoute(
        path: kHomeView,
        builder: (context, state) => const HomeView(),
      ),
      GoRoute(
        path: kSeeMorePopularMovie,
        builder: (context, state) => const SeeMorePopularMovie(),
      ),
      GoRoute(
        path: kSeeMoreTopRatedMovie,
        builder: (context, state) => const SeeMoreTopRatedMovie(),
      ),
      GoRoute(
        path: kSearchMovieView,
        builder: (context, state) => BlocProvider(
          create: (context) => SearchMovieCubit(getIt<SearchMoviesUseCase>()),
          child: const SearchViewMovieBody(),
        ),
      ),
      GoRoute(
        path: kSeeMorePopularTv,
        builder: (context, state) => const SeeMorePopularTv(),
      ),
      GoRoute(
        path: kSeeMoreTopRatedTv,
        builder: (context, state) => const SeeMoreTopRatedTv(),
      ),
      GoRoute(
        path: kSearchTvView,
        builder: (context, state) => BlocProvider(
          create: (context) => SearchTvCubit(getIt<SearchTvUseCase>()),
          child: const SearchViewTvBody(),
        ),
      ),
      GoRoute(
        path: kMainMovieScreen,
        builder: (context, state) => const MainMoviesScreen(),
      ),
      GoRoute(
        path: kMainTvScreen,
        builder: (context, state) => const MainTvsScreen(),
      ),
      GoRoute(
        path: '/movieDetailScreen/:userId',
        builder: (context, state) {
          final idString = state.pathParameters['userId'];
          // Extract the 'id' parameter from the route as a string
          final id = int.tryParse(idString ?? '') ?? 0;
          // Parse the string to an integer
          // Use 0 as the default value if parsing fails
          return MovieDetailScreen(
            id: id,
          );
        },
      ),
      GoRoute(
        path: '/tvDetailScreen/:userId',
        builder: (context, state) {
          final idString = state.pathParameters['userId'];
          // Extract the 'id' parameter from the route as a string
          final id = int.tryParse(idString ?? '') ?? 0;
          // Parse the string to an integer
          // Use 0 as the default value if parsing fails
          return TvDetailScreen(
            id: id,
          );
        },
      ),
    ],
  );
}
