import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:medcare/core/colors/app_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleAnimation;

  bool showImageStage = false;
  bool showBrandStage = false;

  final double initialSize = 55.0;
  final double holdSize = 200.0;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 950),
    );

    final double holdScale = holdSize / initialSize;
    const double finalScale = 80.0;

    _scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(
          begin: 1.0,
          end: holdScale,
        ).chain(CurveTween(curve: Curves.fastEaseInToSlowEaseOut)),
        weight: 82,
      ),
      TweenSequenceItem(
        tween: Tween<double>(
          begin: holdScale,
          end: finalScale,
        ).chain(CurveTween(curve: Curves.easeOutCubic)),
        weight: 18,
      ),
    ]).animate(_controller);

    _runSequence();
  }

  Future<void> _runSequence() async {
    await Future<void>.delayed(const Duration(milliseconds: 450));
    if (!mounted) return;

    await _controller.forward();
    if (!mounted) return;

    setState(() {
      showImageStage = true;
    });

    await Future<void>.delayed(const Duration(milliseconds: 850));
    if (!mounted) return;

    setState(() {
      showBrandStage = true;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool tealStage = _controller.isAnimating || showImageStage;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness:
            tealStage ? Brightness.light : Brightness.dark,
        statusBarBrightness: tealStage ? Brightness.dark : Brightness.light,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness:
            tealStage ? Brightness.light : Brightness.dark,
        systemNavigationBarContrastEnforced: false,
      ),
      child: Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.transparent,
        body: Stack(
          fit: StackFit.expand,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              color: tealStage ? AppColors.primary : AppColors.white,
            ),
            if (showImageStage)
              Positioned.fill(
                child: AnimatedOpacity(
                  opacity: showBrandStage ? 0 : 1,
                  duration: const Duration(milliseconds: 350),
                  child: SvgPicture.asset(
                    'assets/images/splash2.svg',
                    fit: BoxFit.cover,
                    placeholderBuilder: (_) => ColoredBox(
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ),
            if (showBrandStage)
              Positioned.fill(
                child: AnimatedOpacity(
                  opacity: showBrandStage ? 1 : 0,
                  duration: const Duration(milliseconds: 450),
                  child: SvgPicture.asset(
                    'assets/images/spash3.svg',
                    fit: BoxFit.cover,
                    placeholderBuilder: (_) => ColoredBox(
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ),
            if (!showImageStage)
              Center(
                child: ScaleTransition(
                  scale: _scaleAnimation,
                  child: Container(
                    width: initialSize.r,
                    height: initialSize.r,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
