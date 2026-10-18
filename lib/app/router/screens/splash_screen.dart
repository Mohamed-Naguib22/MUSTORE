import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mustore/features/auth/presentation/controllers/auth_cubit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    context.read<AuthCubit>().restoreSession();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;

    return Scaffold(
      body: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              scheme.primary,
              Color.lerp(scheme.primary, scheme.secondary, 0.35)!,
            ],
          ),
        ),
        child: SizedBox.expand(
          child: SafeArea(
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: 0, end: 1),
              duration: const Duration(milliseconds: 700),
              curve: Curves.easeOutCubic,
              builder: (_, value, child) => Opacity(
                opacity: value,
                child: Transform.scale(scale: 0.85 + 0.15 * value, child: child),
              ),
              child: Column(
                children: [
                  const Spacer(flex: 3),
                  Container(
                    height: 96,
                    width: 96,
                    decoration: BoxDecoration(
                      color: scheme.onPrimary.withValues(alpha: 0.16),
                      borderRadius: BorderRadius.circular(28),
                      border: Border.all(
                        color: scheme.onPrimary.withValues(alpha: 0.3),
                      ),
                    ),
                    child: Icon(
                      Icons.shopping_bag_rounded,
                      size: 52,
                      color: scheme.onPrimary,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'MUSTORE',
                    style: text.headlineMedium?.copyWith(
                      color: scheme.onPrimary,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Everything you need, in one place',
                    style: text.bodyMedium?.copyWith(
                      color: scheme.onPrimary.withValues(alpha: 0.8),
                    ),
                  ),
                  const Spacer(flex: 3),
                  SizedBox(
                    height: 24,
                    width: 24,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.5,
                      color: scheme.onPrimary,
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}