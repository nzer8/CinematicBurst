import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movies/my_drawer.dart';

import 'core/utils/app_router.dart';
import 'home_view_body.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff212121),
        elevation: 0,
      ),
      drawer: const MyDrawer(),
      body: const HomeViewBody(),
    );
  }
}
