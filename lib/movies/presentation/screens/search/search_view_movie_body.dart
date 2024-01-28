import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:movies/movies/presentation/controller/search/search_movie_state.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/network/api_constance.dart';
import '../../../../core/utils/custom_search_text_field.dart';
import '../../controller/search/search_movie_cubit.dart';

class SearchViewMovieBody extends StatelessWidget {
  const SearchViewMovieBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
        backgroundColor: Colors.grey[800],
        child: const Icon(Icons.arrow_back_ios_new),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 60),
            CustomSearchTextField(
              onChanged: (query) {
                if (query.isNotEmpty) {
                  context
                      .read<SearchMovieCubit>()
                      .fetchSearchMovie(query: query);
                }
              },
              onSubmitted: (query) {
                if (query.isNotEmpty) {
                  context
                      .read<SearchMovieCubit>()
                      .fetchSearchMovie(query: query);
                }
              },
            ),
            const SizedBox(height: 30),
            const Text(
              'Search Result',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 25),
            const Expanded(child: SearchResultListView()),
          ],
        ),
      ),
    );
  }
}

class SearchResultListView extends StatelessWidget {
  const SearchResultListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchMovieCubit, SearchMovieState>(
      builder: (context, state) {
        if (state is SearchMovieSuccess) {
          return ListView.builder(
            padding: EdgeInsets.zero,
            physics: const BouncingScrollPhysics(),
            itemCount: state.movie.length,
            itemBuilder: (context, index) {
              final movie = state.movie[index];
              final id = movie.id.toString();
              return GestureDetector(
                onTap: () {
                  GoRouter.of(context).push('/movieDetailScreen/$id');
                },
                child: FadeInUp(
                  from: 100,
                  duration: const Duration(milliseconds: 500),
                  child: Container(
                    height: 180,
                    margin: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 3,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: const Color(0xff303030),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: CachedNetworkImage(
                            width: 100.0,
                            height: 170,
                            fit: BoxFit.cover,
                            imageUrl:
                                ApiConstance.imageUrl(movie.backdropPath!),
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
                        const SizedBox(width: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 25),
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 1.7,
                              child: Text(
                                movie.title!,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 7,
                                    vertical: 4,
                                  ),
                                ),
                                const SizedBox(width: 20),
                              ],
                            ),
                            const SizedBox(height: 23),
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 1.7,
                              child: Text(
                                movie.overView!,
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
          );
        } else if (state is SearchMovieFailure) {
          return SizedBox(
            height: 170.0,
            child: Center(
              child: Text(state.errMessage),
            ),
          );
        } else if (state is SearchMovieLoading) {
          return const SizedBox(
            height: 170.0,
            child: Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            ),
          );
        } else {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'No Movie'.toUpperCase(),
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'start searching now'.toUpperCase(),
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
