import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movies/movies/presentation/screens/search/search_view_movie_body.dart';

import '../../../../core/utils/app_router.dart';

class SearchView extends StatelessWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            GoRouter.of(context).push(AppRouter.kHomeView);
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: SafeArea(
        child: SearchViewMovieBody(),
      ),
    );
  }
}
