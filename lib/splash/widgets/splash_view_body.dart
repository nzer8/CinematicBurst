import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movies/splash/widgets/sliding_text.dart';

import '../../core/utils/app_router.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({Key? key}) : super(key: key);

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<Offset> slidingAnimation;
  late Animation<Offset> slidingAnimationImage;

  @override
  void initState() {
    super.initState();
    initSlidingAnimation();

    navigateToHome();
  }

  void disPose() {
    super.dispose();
    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AnimatedBuilder(
            animation: slidingAnimationImage,
            builder: (context, _) {
              return SlideTransition(
                position: slidingAnimationImage,
                child: Image.asset(
                  'assets/images/cinama_icon.png',
                ),
              );
            }),
        const SizedBox(
          height: 8,
        ),
        SlidingText(slidingAnimation: slidingAnimation),
      ],
    );
  }

  void initSlidingAnimation() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    slidingAnimation = Tween<Offset>(
      begin: const Offset(0, 12),
      end: Offset.zero,
    ).animate(animationController);
    animationController.forward();

    slidingAnimationImage = Tween<Offset>(
      begin: const Offset(0, -2),
      end: const Offset(0, 0),
    ).animate(animationController);
    animationController.forward();
  }

  void navigateToHome() {
    Future.delayed(
      const Duration(seconds: 4),
      () {
        GoRouter.of(context).push(AppRouter.kHomeView);
      },
    );
  }
}
