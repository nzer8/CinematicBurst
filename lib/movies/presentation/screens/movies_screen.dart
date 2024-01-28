import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies/core/services/services_locator.dart';
import 'package:movies/core/utils/app_router.dart';
import 'package:movies/core/utils/app_string.dart';
import 'package:movies/movies/presentation/components/now_playing_components.dart';
import 'package:movies/movies/presentation/components/popular_components.dart';
import 'package:movies/movies/presentation/components/top_rated_components.dart';
import 'package:movies/movies/presentation/controller/movie/movies_bloc.dart';
import 'package:movies/movies/presentation/controller/movie/movies_event.dart';

class MainMoviesScreen extends StatelessWidget {
  const MainMoviesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<MoviesBloc>()
        ..add(GetNowPlayingEvent())
        ..add(GetPopularEvent())
        ..add(GetTopRatedEvent()),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xff212121),
          elevation: 0,
          centerTitle: true,
          title: const Text(AppString.moviesSection),
          leading: IconButton(
            onPressed: () {
              GoRouter.of(context).push(AppRouter.kHomeView);
            },
            icon: const Icon(Icons.arrow_back),
          ),
          actions: [
            IconButton(
              onPressed: () {
                GoRouter.of(context).push(AppRouter.kSearchMovieView);
              },
              icon: const Icon(Icons.search_sharp),
            ),
          ],
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          key: const Key('movieScrollView'),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const NowPlayingComponents(),
              Container(
                margin: const EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppString.popular,
                      style: GoogleFonts.poppins(
                        fontSize: 19,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.15,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        GoRouter.of(context)
                            .push(AppRouter.kSeeMorePopularMovie);
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Text(AppString.seeMore),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 16.0,
                              color: Colors.white,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const PopularComponents(),
              Container(
                margin: const EdgeInsets.fromLTRB(
                  16.0,
                  24.0,
                  16.0,
                  8.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppString.topRated,
                      style: GoogleFonts.poppins(
                        fontSize: 19,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.15,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        GoRouter.of(context)
                            .push(AppRouter.kSeeMoreTopRatedMovie);
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Text(AppString.seeMore),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 16.0,
                              color: Colors.white,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const TopRatedComponents(),
              const SizedBox(height: 50.0),
            ],
          ),
        ),
      ),
    );
  }
}
