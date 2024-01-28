import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:movies/tvs/presentation/controller/tvs/tvs_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/network/api_constance.dart';
import '../../../core/utils/enums.dart';

class PopularTvComponents extends StatelessWidget {
  const PopularTvComponents({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TvsBloc, TvsState>(
      buildWhen: (previous, current) =>
          previous.popularTvState != current.popularTvState,
      builder: (context, state) {
        switch (state.popularTvState) {
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
            return FadeIn(
              //هي الويدجيت مشان وقت يظهر العنصر كيف يظهر(منظر خافت حلو)
              duration: const Duration(milliseconds: 500),
              child: SizedBox(
                height: 170,
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  itemCount: state.popularTv.length,
                  itemBuilder: (context, index) {
                    final tv = state.popularTv[index];
                    final id = tv.id.toString();

                    return Container(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: InkWell(
                        onTap: () {
                          GoRouter.of(context).push('/tvDetailScreen/$id');
                        },
                        child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8.0)),
                          child: CachedNetworkImage(
                            width: 120.0,
                            fit: BoxFit.cover,
                            imageUrl: ApiConstance.imageUrl(tv.backdropPath),
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
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          case RequestState.error:
            return SizedBox(
              height: 170.0,
              child: Center(
                child: Text(state.popularTvMessage),
              ),
            );
        }
      },
    );
  }
}
