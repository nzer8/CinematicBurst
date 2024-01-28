import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies/core/services/services_locator.dart';
import 'package:movies/core/utils/enums.dart';
import 'package:movies/tvs/domain/entities/genres_tv.dart';
import 'package:movies/tvs/presentation/controller/tv_details_bloc/tv_detail_bloc.dart';

import 'package:shimmer/shimmer.dart';

import '../../../core/network/api_constance.dart';
import '../../../core/utils/app_string.dart';

class TvDetailScreen extends StatelessWidget {
  final int id;

  const TvDetailScreen({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(id);
    return BlocProvider(
      create: (context) => getIt<TvDetailBloc>()
        ..add(GetTvDetailsEvent(id))
        ..add(GetTvRecommendationEvent(id)),
      child: const Scaffold(
        // appBar: AppBar(),
        body: TvDetailContent(),
      ),
    );
  }
}

class TvDetailContent extends StatelessWidget {
  const TvDetailContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TvDetailBloc, TvDetailState>(
      builder: (context, state) {
        switch (state.tvDetailState) {
          case RequestState.loading:
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            );
          case RequestState.loaded:
            return CustomScrollView(
              physics: const BouncingScrollPhysics(),
              key: const Key('tvDetailScrollView'),
              slivers: [
                SliverAppBar(
                  backgroundColor: const Color(0xff212125),
                  pinned: false,
                  expandedHeight: 250.0,
                  flexibleSpace: FlexibleSpaceBar(
                    background: FadeIn(
                      duration: const Duration(milliseconds: 500),
                      child: ShaderMask(
                        shaderCallback: (rect) {
                          return const LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.white,
                              Colors.black,
                              Colors.white
                              //Colors.transparent,
                            ],
                            stops: [0.0, 1.0, 0],
                          ).createShader(
                            Rect.fromLTRB(0.0, 0.0, rect.width, rect.height),
                          );
                        },
                        blendMode: BlendMode.dstIn,
                        child: CachedNetworkImage(
                          width: MediaQuery.of(context).size.width,
                          imageUrl: ApiConstance.imageUrl(
                              state.tvDetail!.backdropPath),
                          placeholder: (context, url) => Shimmer.fromColors(
                            baseColor: Colors.grey[850]!,
                            highlightColor: Colors.grey[800]!,
                            child: Container(
                              height: 400.0,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                          ),
                          errorWidget: (context, url, error) => const Center(
                            child: Icon(
                              Icons.error,
                              size: 80,
                              color: Colors.white,
                            ),
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: FadeInUp(
                    from: 20,
                    duration: const Duration(milliseconds: 500),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            state.tvDetail!.name,
                            style: GoogleFonts.poppins(
                              fontSize: 23,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1.2,
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 2.0,
                                  horizontal: 8.0,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.grey[800],
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                                child: Text(
                                  state.tvDetail!.firstAirDate.split('-')[0],
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16.0),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                    size: 20.0,
                                  ),
                                  const SizedBox(width: 4.0),
                                  Text(
                                    (state.tvDetail!.voteAverage / 2)
                                        .toStringAsFixed(1),
                                    style: const TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 1.2,
                                    ),
                                  ),
                                  const SizedBox(width: 4.0),
                                  Text(
                                    '(${state.tvDetail!.voteAverage})',
                                    style: const TextStyle(
                                      fontSize: 1.0,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 1.2,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(width: 16.0),
                              Text(
                                ' ${(state.tvDetail!.numberOfSeasons).toInt()} Seasons',
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 1.2,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20.0),
                          Text(
                            state.tvDetail!.overView,
                            style: const TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w400,
                              letterSpacing: 1.2,
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          Text(
                            '${AppString.genres}: ${_showGenres(state.tvDetail!.genres)}',
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 12.0,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 1.2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 24.0),
                  sliver: SliverToBoxAdapter(
                    child: FadeInUp(
                      from: 20,
                      duration: const Duration(milliseconds: 500),
                      child: Text(
                        AppString.moreLikeThis.toUpperCase(),
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 24.0),
                  sliver: _showRecommendations(),
                ),
              ],
            );
          case RequestState.error:
            return SizedBox(
              height: 400.0,
              child: Center(
                child: Text(state.messageTvDetails),
              ),
            );
        }
      },
    );
  }

  String _showGenres(List<GenresTv> genres) {
    String result = '';
    for (var genre in genres) {
      result += '${genre.name}, ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }

  Widget _showRecommendations() {
    return BlocBuilder<TvDetailBloc, TvDetailState>(
      builder: (context, state) {
        if (state.recommendationsTvs.isNotEmpty) {
          return SliverGrid(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final recommendation = state.recommendationsTvs[index];
                final id = recommendation.id.toString();
                return GestureDetector(
                  onTap: () {
                    GoRouter.of(context).push('/tvDetailScreen/$id');
                  },
                  child: FadeInUp(
                    from: 20,
                    duration: const Duration(milliseconds: 500),
                    child: ClipRRect(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(4.0)),
                      child: CachedNetworkImage(
                        imageUrl:
                            ApiConstance.imageUrl(recommendation.backdropPath!),
                        placeholder: (context, url) => Shimmer.fromColors(
                          baseColor: Colors.grey[850]!,
                          highlightColor: Colors.grey[800]!,
                          child: Container(
                            height: 170.0,
                            width: 120.0,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                        ),
                        errorWidget: (context, url, error) => const Icon(
                          Icons.error,
                          color: Colors.white,
                        ),
                        height: 180.0,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              },
              childCount: state.recommendationsTvs.length,
            ),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
              childAspectRatio: 0.7,
              crossAxisCount: 3,
            ),
          );
        } else {
          return SliverToBoxAdapter(
            child: SizedBox(
              height: 120,
              child: Center(
                child: Text(
                  AppString.noAvailable,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.grey[400],
                  ),
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
