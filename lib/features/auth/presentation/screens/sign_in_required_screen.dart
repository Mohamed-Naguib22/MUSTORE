import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mustore/app/app_page.dart';
import 'package:mustore/core/style/dimens/dimens.dart';
import 'package:mustore/core/utils/constants/app_assets.dart';
import 'package:mustore/core/widgets/buttons/app_button.dart';
import 'package:mustore/core/widgets/media/app_asset.dart';
import 'package:mustore/features/auth/presentation/widgets/auth_scaffold.dart';
import 'package:mustore/generated/l10n.dart';

class SignInRequiredScreen extends StatelessWidget {
  const SignInRequiredScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);

    return AuthScaffold(
      icon: Icons.lock_outline_rounded,
      title: l10n.signInRequiredTitle,
      subtitle: l10n.signInRequiredMessage,
      child: Column(
        children: [
          const Center(
            child: AppAsset(AppAssets.emptyCart, height: Dimens.illustration),
          ),
          Dimens.gapXl,
          AppButton(
            label: l10n.signInRequiredAction,
            icon: Icons.login_rounded,
            onPressed: () => context.push(AppPage.login.path),
          ),
          Dimens.gapMd,
          AppButton(
            label: l10n.signInRequiredSignUp,
            variant: AppButtonVariant.tonal,
            onPressed: () => context.push(AppPage.register.path),
          ),
        ],
      ),
    );
  }
}