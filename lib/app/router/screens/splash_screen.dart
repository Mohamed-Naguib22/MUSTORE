import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mustore/core/style/colors/app_colors.dart';
import 'package:mustore/core/style/dimens/dimens.dart';
import 'package:mustore/features/auth/presentation/controllers/auth_cubit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  static const double _logoSize = Dimens.xxxl * 2;
  static const double _logoIconSize = Dimens.iconLg + Dimens.md;
  static const double _logoRadius = Dimens.radiusXl + Dimens.sm;

  @override
  void initState() {
    super.initState();
    context.read<AuthCubit>().restoreSession();
  }

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;

    const background = AppColors.primary;
    final backgroundEnd = Color.lerp(
      AppColors.primary,
      AppColors.primaryLight,
      0.6,
    )!;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: AppColors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
        systemNavigationBarColor: background,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: background,
        body: DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [background, backgroundEnd],
            ),
          ),
          child: SizedBox.expand(
            child: SafeArea(
              child: TweenAnimationBuilder<double>(
                tween: Tween(begin: 0, end: 1),
                duration: Dimens.slow * 2,
                curve: Curves.easeOutCubic,
                builder: (_, value, child) => Opacity(
                  opacity: value,
                  child: Transform.scale(
                    scale: 0.85 + 0.15 * value,
                    child: child,
                  ),
                ),
                child: Column(
                  children: [
                    const Spacer(flex: 3),
                    Container(
                      height: _logoSize,
                      width: _logoSize,
                      decoration: BoxDecoration(
                        color: AppColors.secondary,
                        borderRadius: BorderRadius.circular(_logoRadius),
                      ),
                      child: const Icon(
                        Icons.shopping_bag_rounded,
                        size: _logoIconSize,
                        color: AppColors.onSecondary,
                      ),
                    ),
                    Dimens.gapLg,
                    Text(
                      'MUSTORE',
                      style: text.headlineMedium?.copyWith(
                        color: AppColors.white,
                        fontWeight: FontWeight.w800,
                        letterSpacing: Dimens.xxs,
                      ),
                    ),
                    Dimens.gapSm,
                    Text(
                      'Everything you need, in one place',
                      style: text.bodyMedium?.copyWith(
                        color: AppColors.white.withValues(alpha: 0.75),
                      ),
                    ),
                    const Spacer(flex: 3),
                    const SizedBox(
                      height: Dimens.iconMd,
                      width: Dimens.iconMd,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.5,
                        color: AppColors.secondary,
                      ),
                    ),
                    Dimens.gapXxl,
                    Dimens.gapSm,
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}