import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies/core/utils/app_string.dart';
import 'package:movies/tvs/presentation/controller/see_more_tv_bloc/see_more_tv_bloc.dart';

import 'package:shimmer/shimmer.dart';

import 'core/network/api_constance.dart';
import 'core/services/services_locator.dart';
import 'core/utils/app_router.dart';
import 'core/utils/enums.dart';
import 'movies/presentation/controller/movie/movies_bloc.dart';
import 'movies/presentation/controller/movie/movies_event.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(8.0, 0.0, 4.0, 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppString.somePopularMovie,
                        style: GoogleFonts.poppins(
                          fontSize: 19,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.15,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          GoRouter.of(context).push(AppRouter.kMainMovieScreen);
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Text(AppString.allMovie),
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
                BlocProvider(
                  create: (context) =>
                      getIt<MoviesBloc>()..add(GetPopularEvent()),
                  child: BlocBuilder<MoviesBloc, MoviesState>(
                    buildWhen: (previous, current) =>
                        previous.popularState != current.popularState,
                    builder: (context, state) {
                      switch (state.popularState) {
                        case RequestState.loading:
                          return const SizedBox(
                            height: 300.0,
                            child: Center(
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            ),
                          );
                        case RequestState.loaded:
                          return FadeIn(
                            duration: const Duration(milliseconds: 500),
                            child: CarouselSlider(
                              options: CarouselOptions(
                                height: 400.0,
                                viewportFraction: 1.0,
                                onPageChanged: (index, reason) {},
                                autoPlay: true,
                                autoPlayInterval: const Duration(seconds: 35),
                              ),
                              items: state.popularMovies.map(
                                (item) {
                                  final id = item.id.toString();
                                  return GestureDetector(
                                    key: const Key('openMovieMinimalDetail'),
                                    onTap: () {
                                      GoRouter.of(context)
                                          .push('/movieDetailScreen/$id');
                                    },
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Stack(
                                        children: [
                                          ShaderMask(
                                            shaderCallback: (rect) {
                                              return const LinearGradient(
                                                begin: Alignment.topCenter,
                                                end: Alignment.bottomCenter,
                                                colors: [
                                                  // fromLTRB
                                                  Colors.transparent,
                                                  Colors.black,
                                                  Colors.black,
                                                  Colors.transparent,
                                                ],
                                                stops: [0, 0.3, 0.5, 1],
                                              ).createShader(
                                                Rect.fromLTRB(0, 0, rect.width,
                                                    rect.height),
                                              );
                                            },
                                            blendMode: BlendMode.dstIn,
                                            child: CachedNetworkImage(
                                              height: 560.0,
                                              imageUrl: ApiConstance.imageUrl(
                                                item.backdropPath,
                                              ),
                                              placeholder: (context, url) =>
                                                  Shimmer.fromColors(
                                                baseColor: Colors.grey[850]!,
                                                highlightColor:
                                                    Colors.grey[800]!,
                                                child: Container(
                                                  height: 400.0,
                                                  decoration: BoxDecoration(
                                                    color: Colors.black,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                  ),
                                                ),
                                              ),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      const Center(
                                                child: Icon(
                                                  Icons.error,
                                                  size: 80,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.bottomCenter,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 16.0),
                                                  child: Text(
                                                    item.title,
                                                    textAlign: TextAlign.center,
                                                    style: const TextStyle(
                                                      fontSize: 24,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ).toList(),
                            ),
                          );
                        case RequestState.error:
                          return SizedBox(
                            height: 400.0,
                            child: Center(
                              child: Text(state.nowPlayingMessage),
                            ),
                          );
                      }
                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(8.0, 10.0, 4.0, 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppString.someTopRatedTvs,
                        style: GoogleFonts.poppins(
                          fontSize: 19,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.15,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          GoRouter.of(context).push(AppRouter.kMainTvScreen);
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Text(AppString.allTvs),
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
              ],
            ),
          ),
        ),
        SliverFillRemaining(
          child: BlocProvider(
            create: (context) =>
                getIt<SeeMoreTvBloc>()..add(SeeMoreTopRatedTvEvent()),
            child: BlocBuilder<SeeMoreTvBloc, SeeMoreTvState>(
              buildWhen: (previous, current) =>
                  previous.topRatedTvState != current.topRatedTvState,
              builder: (context, state) {
                switch (state.topRatedTvState) {
                  case RequestState.loading:
                    return const SizedBox(
                      height: 170.0,
                      child: Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      ),
                    );
                  case RequestState.loaded:
                    return Scaffold(
                      backgroundColor: const Color(0xff1e1e29),
                      body: ListView.builder(
                        itemCount: 6,
                        physics: const NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          final tv = state.topRatedTv[index];
                          final id = tv.id.toString();

                          return GestureDetector(
                            onTap: () {
                              GoRouter.of(context).push('/tvDetailScreen/$id');
                            },
                            child: FadeInUp(
                              from: 100,
                              duration: const Duration(milliseconds: 500),
                              child: Container(
                                height: 180,
                                padding: const EdgeInsets.all(8),
                                margin: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: const Color(0xff303030),
                                ),
                                child: Row(
                                  //mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: CachedNetworkImage(
                                        width: 100.0,
                                        height: 170,
                                        fit: BoxFit.cover,
                                        imageUrl: ApiConstance.imageUrl(
                                            tv.backdropPath),
                                        placeholder: (context, url) =>
                                            Shimmer.fromColors(
                                          baseColor: Colors.grey[850]!,
                                          highlightColor: Colors.grey[800]!,
                                          child: Container(
                                            height: 170.0,
                                            width: 120.0,
                                            decoration: BoxDecoration(
                                              color: Colors.black,
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                          ),
                                        ),
                                        errorWidget: (context, url, error) =>
                                            const Icon(
                                          Icons.error,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                          height: 25,
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              1.7,
                                          child: Text(
                                            tv.name,
                                            style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 7,
                                                      vertical: 4),
                                              decoration: BoxDecoration(
                                                color: Colors.red,
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                              ),
                                              child: Text(
                                                tv.firstAirDate.split('-')[0],
                                              ),
                                            ),
                                            const SizedBox(width: 20.0),
                                            const Icon(
                                              Icons.star,
                                              color: Colors.amber,
                                              size: 20.0,
                                            ),
                                            const SizedBox(width: 4.0),
                                            Text(
                                              (tv.voteAverage / 2)
                                                  .toStringAsFixed(1),
                                              // يعني بصير التقييم من 5
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 23,
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              1.7,
                                          child: Text(
                                            tv.overView,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  case RequestState.error:
                    return SizedBox(
                      height: 170.0,
                      child: Center(
                        child: Text(state.topRatedTvMessage),
                      ),
                    );
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}
