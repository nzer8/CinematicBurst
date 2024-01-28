import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'core/utils/app_router.dart';
import 'core/utils/app_string.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xff212121),
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: const Color(0xff1e1e29),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 130,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        shape: BoxShape.rectangle,
                        image: const DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage('assets/images/cinama.jpeg'),
                        ),
                      ),
                    ),
                    const Positioned(
                      bottom: 70, // Adjust the position as needed
                      left: 0,
                      right: 0,
                      child: Center(
                        child: Text(
                          'Move To Any Screen',
                          style: TextStyle(
                            fontSize: 25,
                            fontStyle: FontStyle.italic,
                            color: Colors.black, // Adjust text color as needed
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          ListTile(
            title: const Text(AppString.moviesSection),
            onTap: () {
              GoRouter.of(context).push(AppRouter.kMainMovieScreen);
            },
          ),
          const MyDivider(color: Colors.grey, thickness: 1),
          ListTile(
            title: const Text(AppString.popularMovie),
            onTap: () {
              GoRouter.of(context).push(AppRouter.kSeeMorePopularMovie);
            },
          ),
          const MyDivider(color: Colors.grey, thickness: 1),
          ListTile(
            title: const Text(AppString.topRatedMovie),
            onTap: () {
              GoRouter.of(context).push(AppRouter.kSeeMoreTopRatedMovie);
            },
          ),
          const MyDivider(color: Colors.grey, thickness: 1),
          ListTile(
            title: const Text("Search for a movie"),
            onTap: () {
              GoRouter.of(context).push(AppRouter.kSearchMovieView);
            },
          ),
          const MyDivider(color: Colors.white, thickness: 2),
          ListTile(
            title: const Text(AppString.tvsSection),
            onTap: () {
              GoRouter.of(context).push(AppRouter.kMainTvScreen);
            },
          ),
          const MyDivider(color: Colors.grey, thickness: 1),
          ListTile(
            title: const Text(AppString.popularTvs),
            onTap: () {
              GoRouter.of(context).push(AppRouter.kSeeMorePopularTv);
            },
          ),
          const MyDivider(color: Colors.grey, thickness: 1),
          ListTile(
            title: const Text(AppString.topRatedTvs),
            onTap: () {
              GoRouter.of(context).push(AppRouter.kSeeMoreTopRatedTv);
            },
          ),
          const MyDivider(color: Colors.grey, thickness: 1),
          ListTile(
            title: const Text("Search for a tv"),
            onTap: () {
              GoRouter.of(context).push(AppRouter.kSearchTvView);
            },
          ),
          const MyDivider(color: Colors.white, thickness: 2),
        ],
      ),
    );
  }
}

class MyDivider extends StatelessWidget {
  const MyDivider({Key? key, required this.color, required this.thickness})
      : super(key: key);
  final Color color;
  final double thickness;
  @override
  Widget build(BuildContext context) {
    return Divider(
      color: color,
      thickness: thickness,
    );
  }
}
