import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:medcare/core/colors/app_colors.dart';
import 'package:medcare/features/authentication/presentation/screens/welcome_page.dart';

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
  bool _didPrecacheBrand = false;
  Uint8List? _splash2ImageBytes;

  final double initialSize = 54.0;
  final double holdSize = 200.0;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1250),
    );

    final double holdScale = holdSize / initialSize;
    const double finalScale = 80.0;

    _scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(
          begin: 1.0,
          end: holdScale,
        ).chain(CurveTween(curve: Curves.easeInOutCubicEmphasized)),
        weight: 72,
      ),
      TweenSequenceItem(
        tween: Tween<double>(
          begin: holdScale,
          end: finalScale,
        ).chain(CurveTween(curve: Curves.easeInOutCubic)),
        weight: 28,
      ),
    ]).animate(_controller);

    _runSequence();
    _loadSplash2Image();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_didPrecacheBrand) return;

    _didPrecacheBrand = true;
    SvgAssetLoader('assets/images/spash3.svg').loadBytes(context);
  }

  Future<void> _loadSplash2Image() async {
    final String svgContent = await rootBundle.loadString(
      'assets/images/splash2.svg',
    );
    final RegExpMatch? match = RegExp(
      r'data:image/[^;]+;base64,([^"]+)',
    ).firstMatch(svgContent);

    if (!mounted || match == null) return;

    setState(() {
      _splash2ImageBytes = base64Decode(match.group(1)!);
    });
  }

  Future<void> _runSequence() async {
    await Future<void>.delayed(const Duration(milliseconds: 850));
    if (!mounted) return;

    await _controller.forward();
    if (!mounted) return;

    setState(() {
      showImageStage = true;
    });

    await Future<void>.delayed(const Duration(milliseconds: 800));
    if (!mounted) return;

    setState(() {
      showBrandStage = true;
    });

    await Future<void>.delayed(const Duration(milliseconds: 400));
    if (!mounted) return;

    Navigator.of(context).pushReplacement(
      MaterialPageRoute<void>(
        builder: (_) => const WelcomePage(),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool tealStage = _controller.isAnimating || showImageStage;
    final bool showCircleStage = !showImageStage;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: tealStage ? Brightness.light : Brightness.dark,
        statusBarBrightness: tealStage ? Brightness.dark : Brightness.light,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: tealStage
            ? Brightness.light
            : Brightness.dark,
        systemNavigationBarContrastEnforced: false,
      ),
      child: Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.transparent,
        body: Stack(
          fit: StackFit.expand,
          children: [
            ColoredBox(
              color: showCircleStage ? AppColors.white : AppColors.primary,
            ),
            if (showImageStage)
              Positioned.fill(
                child: AnimatedOpacity(
                  opacity: showBrandStage ? 0 : 1,
                  duration: const Duration(milliseconds: 250),
                  child: _splash2ImageBytes == null
                      ? const ColoredBox(color: AppColors.primary)
                      : Image.memory(_splash2ImageBytes!, fit: BoxFit.cover),
                ),
              ),
            if (showBrandStage)
              Positioned.fill(
                child: AnimatedOpacity(
                  opacity: showBrandStage ? 1 : 0,
                  duration: const Duration(milliseconds: 220),
                  child: SvgPicture.asset(
                    'assets/images/spash3.svg',
                    fit: BoxFit.cover,
                    placeholderBuilder: (_) => ColoredBox(
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ),
            if (showCircleStage)
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
