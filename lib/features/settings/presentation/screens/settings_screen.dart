import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mustore/core/error/failure_message.dart';
import 'package:mustore/core/style/dimens/dimens.dart';
import 'package:mustore/core/utils/enums/request_status.dart';
import 'package:mustore/core/widgets/buttons/app_button.dart';
import 'package:mustore/core/widgets/cards/app_card.dart';
import 'package:mustore/core/widgets/feedback/app_toast.dart';
import 'package:mustore/core/widgets/inputs/app_switch.dart';
import 'package:mustore/features/auth/domain/enums/auth_status.dart';
import 'package:mustore/features/auth/presentation/controllers/auth_cubit.dart';
import 'package:mustore/features/auth/presentation/controllers/auth_state.dart';
import 'package:mustore/features/settings/presentation/controllers/settings_cubit.dart';
import 'package:mustore/features/settings/presentation/controllers/settings_state.dart';
import 'package:mustore/generated/l10n.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);

    return BlocListener<SettingsCubit, SettingsState>(
      listenWhen: (p, c) => c.failure != null && p.failure != c.failure,
      listener: (context, state) =>
          AppToast.error(context, state.failure!.localizedMessage(context)),
      child: BlocBuilder<SettingsCubit, SettingsState>(
        buildWhen: (p, c) =>
        p.themeMode != c.themeMode || p.locale != c.locale,
        builder: (context, state) {
          final cubit = context.read<SettingsCubit>();
          final isDark = Theme.of(context).brightness == Brightness.dark;
          final isArabic =
              Localizations.localeOf(context).languageCode == 'ar';

          return ListView(
            padding: Dimens.screen,
            children: [
              _Section(
                title: l10n.settingsTheme,
                children: [
                  _SwitchTile(
                    title: l10n.themeDark,
                    value: isDark,
                    onChanged: (v) => cubit
                        .changeTheme(v ? ThemeMode.dark : ThemeMode.light),
                  ),
                ],
              ),
              Dimens.gapXl,
              _Section(
                title: l10n.settingsLanguage,
                children: [
                  _SwitchTile(
                    title: 'العربية',
                    value: isArabic,
                    onChanged: (v) =>
                        cubit.changeLocale(Locale(v ? 'ar' : 'en')),
                  ),
                ],
              ),
              const _LogoutSection(),
            ],
          );
        },
      ),
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({required this.title, required this.children});

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsetsDirectional.only(
            start: Dimens.xs,
            bottom: Dimens.sm,
          ),
          child: Text(
            title,
            style: theme.textTheme.titleSmall?.copyWith(
              color: cs.onSurfaceVariant,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        AppCard(
          variant: AppCardVariant.outlined,
          color: cs.surface,
          padding: EdgeInsets.zero,
          child: Column(
            children: [
              for (var i = 0; i < children.length; i++) ...[
                if (i > 0) Divider(height: 1, color: cs.outline),
                children[i],
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _SwitchTile extends StatelessWidget {
  const _SwitchTile({
    required this.title,
    required this.value,
    required this.onChanged,
  });

  final String title;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: () => onChanged(!value),
      child: Padding(
        padding: Dimens.listTile,
        child: Row(
          children: [
            Expanded(
              child: Text(title, style: theme.textTheme.bodyLarge),
            ),
            Dimens.gapMd,
            AppSwitch(value: value, onChanged: onChanged),
          ],
        ),
      ),
    );
  }
}

class _LogoutSection extends StatelessWidget {
  const _LogoutSection();

  @override
  Widget build(BuildContext context) {
    final signedIn = context.select(
          (AuthCubit c) => c.state.authStatus == AuthStatus.authenticated,
    );
    if (!signedIn) return const SizedBox.shrink();

    final isLoading = context.select(
          (AuthCubit c) =>
      c.state.action == AuthAction.revokeSession &&
          c.state.status == RequestStatus.loading,
    );

    return Column(
      children: [
        Dimens.gapXl,
        AppButton(
          label: S.of(context).authLogOut,
          variant: AppButtonVariant.danger,
          isLoading: isLoading,
          onPressed: () => context.read<AuthCubit>().logout(),
        ),
      ],
    );
  }
}