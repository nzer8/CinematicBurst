import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies/core/services/services_locator.dart';
import 'package:movies/core/utils/app_router.dart';
import 'package:movies/core/utils/app_string.dart';

import 'package:movies/tvs/presentation/components/popular_tv_components.dart';
import 'package:movies/tvs/presentation/components/top_rated_tv_components.dart';

import 'package:movies/tvs/presentation/controller/tvs/tvs_bloc.dart';

import '../components/on_the_air_components.dart';

class MainTvsScreen extends StatelessWidget {
  const MainTvsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<TvsBloc>()
        ..add(GetOnTheAirTvsEvent())
        ..add(GetPopularTvsEvent())
        ..add(GetTopRatedTvsEvent()),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xff212121),
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              GoRouter.of(context).push(AppRouter.kHomeView);
            },
            icon: const Icon(Icons.arrow_back),
          ),
          centerTitle: true,
          title: const Text(AppString.tvsSection),
          actions: [
            IconButton(
              onPressed: () {
                GoRouter.of(context).push(AppRouter.kSearchTvView);
              },
              icon: const Icon(Icons.search_sharp),
            ),
          ],
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          key: const Key('tvScrollView'),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const OnTheAirComponents(),
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
                        GoRouter.of(context).push(AppRouter.kSeeMorePopularTv);
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
              const PopularTvComponents(),
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
                        GoRouter.of(context).push(AppRouter.kSeeMoreTopRatedTv);
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
              const TopRatedTvComponents(),
              const SizedBox(height: 50.0),
            ],
          ),
        ),
      ),
    );
  }
}
