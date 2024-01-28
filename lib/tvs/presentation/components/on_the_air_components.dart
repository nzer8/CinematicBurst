import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:movies/tvs/presentation/controller/tvs/tvs_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/network/api_constance.dart';
import '../../../core/utils/app_string.dart';
import '../../../core/utils/enums.dart';
import '../screens/tv_detail_screen.dart';

class OnTheAirComponents extends StatelessWidget {
  const OnTheAirComponents({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TvsBloc, TvsState>(
      buildWhen: (previous, current) =>
          previous.onTheAirTvState != current.onTheAirTvState,
      builder: (context, state) {
        switch (state.onTheAirTvState) {
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
                  autoPlayInterval: const Duration(seconds: 40),
                ),
                items: state.onTheAirTv.map(
                  (item) {
                    final id = item.id.toString();

                    return GestureDetector(
                      key: const Key('openMovieMinimalDetail'),
                      onTap: () {
                        GoRouter.of(context).push('/tvDetailScreen/$id');
                      },
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
                                Rect.fromLTRB(0, 0, rect.width, rect.height),
                              );
                            },
                            blendMode: BlendMode.dstIn,
                            child: CachedNetworkImage(
                              height: 560.0,
                              imageUrl:
                                  ApiConstance.imageUrl(item.backdropPath),
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
                              errorWidget: (context, url, error) =>
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
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 16.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.circle,
                                        color: Colors.redAccent,
                                        size: 16.0,
                                      ),
                                      const SizedBox(width: 4.0),
                                      Text(
                                        AppString.onTheAir.toUpperCase(),
                                        style: const TextStyle(
                                          fontSize: 16.0,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 16.0),
                                  child: Text(
                                    item.name,
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
                    );
                  },
                ).toList(),
              ),
            );
          case RequestState.error:
            return SizedBox(
              height: 400.0,
              child: Center(
                child: Text(state.onTheAirTvMessage),
              ),
            );
        }
      },
    );
  }
}
