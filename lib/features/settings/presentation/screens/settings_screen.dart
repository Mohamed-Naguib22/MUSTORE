import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mustore/core/error/failure_message.dart';
import 'package:mustore/core/services/localization/language_codes.dart';
import 'package:mustore/core/style/dimens/dimens.dart';
import 'package:mustore/core/utils/constants/app_assets.dart';
import 'package:mustore/core/utils/enums/request_status.dart';
import 'package:mustore/core/widgets/feedback/app_toast.dart';
import 'package:mustore/core/widgets/inputs/app_switch.dart';
import 'package:mustore/core/widgets/media/app_asset.dart';
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

    return MultiBlocListener(
      listeners: [
        BlocListener<SettingsCubit, SettingsState>(
          listenWhen: (p, c) => c.failure != null && p.failure != c.failure,
          listener: (context, state) =>
              AppToast.error(context, state.failure!.localizedMessage(context)),
        ),
        BlocListener<AuthCubit, AuthState>(
          listenWhen: (p, c) =>
          c.action == AuthAction.revokeSession &&
              c.status == RequestStatus.success &&
              p.status != RequestStatus.success,
          listener: (context, state) =>
              AppToast.success(context, l10n.logoutSuccess),
        ),
      ],
      child: BlocBuilder<SettingsCubit, SettingsState>(
        buildWhen: (p, c) => p.themeMode != c.themeMode || p.locale != c.locale,
        builder: (context, state) {
          final cubit = context.read<SettingsCubit>();
          final isDark = Theme.of(context).brightness == Brightness.dark;
          final isArabic =
              Localizations.localeOf(context).languageCode == LanguageCodes.ar;

          return ListView(
            padding: Dimens.screen,
            children: [
              _Section(
                title: l10n.settingsTheme,
                children: [
                  _SwitchTile(
                    leading: _LeadingBox(
                      child: AnimatedSwitcher(
                        duration: Dimens.fast,
                        transitionBuilder: (child, anim) => ScaleTransition(
                          scale: anim,
                          child: FadeTransition(opacity: anim, child: child),
                        ),
                        child: Icon(
                          isDark
                              ? Icons.dark_mode_rounded
                              : Icons.light_mode_rounded,
                          key: ValueKey(isDark),
                        ),
                      ),
                    ),
                    title: l10n.themeDark,
                    value: isDark,
                    onChanged: (v) =>
                        cubit.changeTheme(v ? ThemeMode.dark : ThemeMode.light),
                  ),
                ],
              ),
              Dimens.gapXl,
              _Section(
                title: l10n.settingsLanguage,
                children: [
                  _SwitchTile(
                    leading: _LeadingBox(
                      transparent: true,
                      child: ClipRRect(
                        borderRadius: Dimens.borderSm,
                        child: SizedBox(
                          width: Dimens.xxl,
                          height: Dimens.xl,
                          child: AppAsset(
                            isArabic ? AppAssets.flagEg : AppAssets.flagEn,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    title: isArabic
                        ? LanguageCodes.arabicLabel
                        : LanguageCodes.englishLabel,
                    value: isArabic,
                    onChanged: (v) => cubit.changeLocale(
                      v ? LanguageCodes.arabic : LanguageCodes.english,
                    ),
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
  const _Section({required this.children, this.title});

  final String? title;
  final List<Widget> children;

  static const double _dividerInset = Dimens.lg + Dimens.iconLg + Dimens.md;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          Padding(
            padding: const EdgeInsetsDirectional.only(
              start: Dimens.sm,
              bottom: Dimens.sm,
            ),
            child: Text(
              title!,
              style: theme.textTheme.titleSmall?.copyWith(
                color: cs.onSurfaceVariant,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        Material(
          color: cs.surface,
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: Dimens.borderLg,
            side: BorderSide(color: cs.outlineVariant),
          ),
          child: Column(
            children: [
              for (var i = 0; i < children.length; i++) ...[
                if (i > 0)
                  const Padding(
                    padding: EdgeInsetsDirectional.only(start: _dividerInset),
                    child: Divider(),
                  ),
                children[i],
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _TileRow extends StatelessWidget {
  const _TileRow({
    required this.title,
    this.leading,
    this.trailing,
    this.titleColor,
    this.onTap,
  });

  final Widget? leading;
  final String title;
  final Widget? trailing;
  final Color? titleColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return MergeSemantics(
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsetsDirectional.symmetric(
            horizontal: Dimens.lg,
            vertical: Dimens.md,
          ),
          child: Row(
            children: [
              if (leading != null) ...[
                leading!,
                Dimens.gapMd,
              ],
              Expanded(
                child: Text(
                  title,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: titleColor,
                  ),
                ),
              ),
              if (trailing != null) ...[
                Dimens.gapMd,
                trailing!,
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _SwitchTile extends StatelessWidget {
  const _SwitchTile({
    required this.title,
    required this.value,
    required this.onChanged,
    this.leading,
  });

  final Widget? leading;
  final String title;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return _TileRow(
      leading: leading,
      title: title,
      onTap: () => onChanged(!value),
      trailing: AppSwitch(value: value, onChanged: onChanged),
    );
  }
}

class _LeadingBox extends StatelessWidget {
  const _LeadingBox({
    required this.child,
    this.transparent = false,
    this.color,
    this.foreground,
  });

  final Widget child;
  final bool transparent;
  final Color? color;
  final Color? foreground;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Container(
      width: Dimens.iconLg,
      height: Dimens.iconLg,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: transparent ? null : (color ?? cs.primaryContainer),
        borderRadius: Dimens.borderMd,
        border: transparent ? Border.all(color: cs.outlineVariant) : null,
      ),
      child: IconTheme(
        data: IconThemeData(
          color: foreground ?? cs.onPrimaryContainer,
          size: Dimens.iconMd,
        ),
        child: child,
      ),
    );
  }
}

class _LogoutSection extends StatelessWidget {
  const _LogoutSection();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

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
        _Section(
          children: [
            _TileRow(
              leading: _LeadingBox(
                color: cs.errorContainer,
                foreground: cs.onErrorContainer,
                child: const Icon(Icons.logout_rounded),
              ),
              title: S.of(context).authLogOut,
              titleColor: cs.error,
              onTap: isLoading ? null : () => context.read<AuthCubit>().logout(),
              trailing: isLoading
                  ? SizedBox(
                width: Dimens.iconMd,
                height: Dimens.iconMd,
                child: CircularProgressIndicator(
                  strokeWidth: Dimens.xxs,
                  color: cs.error,
                ),
              )
                  : null,
            ),
          ],
        ),
      ],
    );
  }
}