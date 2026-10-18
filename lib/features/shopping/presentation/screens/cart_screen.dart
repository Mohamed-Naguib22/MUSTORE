import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mustore/app/app_page.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Expanded(child: Center(child: Text('Cart'))),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () => context.pushNamed(AppPage.checkout.name),
                child: const Text('Checkout'),
              ),
            ),
          ),
        ),
      ],
    );
  }
}