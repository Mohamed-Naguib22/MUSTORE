import 'package:flutter/material.dart';

class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({super.key, this.onBack});

  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('404',
                  style: Theme.of(context)
                      .textTheme
                      .displayLarge
                      ?.copyWith(color: scheme.primary)),
              const SizedBox(height: 8),
              const Text('Page not found'),
              const SizedBox(height: 24),
              FilledButton(
                onPressed: onBack,
                child: const Text('Back to home'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}