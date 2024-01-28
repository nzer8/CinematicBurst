import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:movies/core/utils/app_string.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/network/api_constance.dart';
import '../../../core/services/services_locator.dart';
import '../../../core/utils/enums.dart';
import '../controller/see_more_tv_bloc/see_more_tv_bloc.dart';

class SeeMoreTopRatedTv extends StatelessWidget {
  const SeeMoreTopRatedTv({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<SeeMoreTvBloc>()..add(SeeMoreTopRatedTvEvent()),
      child: BlocBuilder<SeeMoreTvBloc, SeeMoreTvState>(
        buildWhen: (previous, current) =>
            previous.topRatedTvState != current.topRatedTvState,
        builder: (context, state) {
          switch (state.topRatedTvState) {
            case RequestState.loading:
              return const Scaffold(
                body: SizedBox(
                  child: Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  ),
                ),
              );
            case RequestState.loaded:
              return Scaffold(
                backgroundColor: const Color(0xff1e1e29),
                appBar: AppBar(
                  title: const Text(AppString.topRatedTvs),
                  centerTitle: true,
                  elevation: 0,
                  backgroundColor: const Color(0xff0c0c10),
                ),
                body: ListView.builder(
                  itemCount: state.topRatedTv.length,
                  physics: const BouncingScrollPhysics(),
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
                                  imageUrl:
                                      ApiConstance.imageUrl(tv.backdropPath),
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 25,
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 1.7,
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
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 7, vertical: 4),
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
                                        (tv.voteAverage / 2).toStringAsFixed(1),
                                        // يعني بصير التقييم من 5
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 23,
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 1.7,
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
    );
  }
}
