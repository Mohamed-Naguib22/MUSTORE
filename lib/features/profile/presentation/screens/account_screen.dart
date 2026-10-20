import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mustore/core/error/failure_message.dart';
import 'package:mustore/core/services/localization/language_codes.dart';
import 'package:mustore/core/style/dimens/dimens.dart';
import 'package:mustore/core/utils/constants/app_assets.dart';
import 'package:mustore/core/utils/enums/request_status.dart';
import 'package:mustore/core/widgets/buttons/app_icon_button.dart';
import 'package:mustore/core/widgets/cards/app_card.dart';
import 'package:mustore/core/widgets/feedback/app_toast.dart';
import 'package:mustore/core/widgets/inputs/app_switch.dart';
import 'package:mustore/core/widgets/lists/app_list_tile.dart';
import 'package:mustore/core/widgets/media/app_asset.dart';
import 'package:mustore/core/widgets/media/app_network_image.dart';
import 'package:mustore/features/auth/domain/entities/auth_session.dart';
import 'package:mustore/features/auth/presentation/controllers/auth_cubit.dart';
import 'package:mustore/features/auth/presentation/controllers/auth_state.dart';
import 'package:mustore/features/settings/presentation/controllers/settings_cubit.dart';
import 'package:mustore/features/settings/presentation/controllers/settings_state.dart';
import 'package:mustore/generated/l10n.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  static const double _dividerIndent = Dimens.lg + Dimens.iconLg + Dimens.md;

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
      child: ListView(
        padding: const EdgeInsetsDirectional.only(
          start: Dimens.lg,
          end: Dimens.lg,
          top: Dimens.lg,
          bottom: Dimens.xl,
        ),
        children: [
          BlocSelector<AuthCubit, AuthState, AuthSession?>(
            selector: (state) => state.session,
            builder: (context, session) => _ProfileCard(
              session: session,
              editTooltip: l10n.accountEditProfile,
              onEdit: () {
              },
            ),
          ),
          _Section(
            title: l10n.accountContact,
            dividerIndent: _dividerIndent,
            children: [
              AppListTile(
                icon: Icons.location_on_outlined,
                title: l10n.accountAddresses,
                onTap: () {
                },
              ),
              AppListTile(
                icon: Icons.phone_outlined,
                title: l10n.accountPhoneNumbers,
                onTap: () {
                },
              ),
            ],
          ),
          BlocBuilder<SettingsCubit, SettingsState>(
            buildWhen: (p, c) =>
            p.themeMode != c.themeMode || p.locale != c.locale,
            builder: (context, state) {
              final cubit = context.read<SettingsCubit>();
              final isDark = Theme.of(context).brightness == Brightness.dark;
              final isArabic = Localizations.localeOf(context).languageCode ==
                  LanguageCodes.ar;

              return _Section(
                title: l10n.accountPreferences,
                dividerIndent: _dividerIndent,
                children: [
                  AppListTile(
                    leading: _FlagBadge(isArabic: isArabic),
                    title: isArabic
                        ? LanguageCodes.arabicLabel
                        : LanguageCodes.englishLabel,
                    subtitle: l10n.settingsLanguage,
                    onTap: () => cubit.changeLocale(
                      isArabic ? LanguageCodes.english : LanguageCodes.arabic,
                    ),
                    trailing: AppSwitch(
                      value: isArabic,
                      onChanged: (v) => cubit.changeLocale(
                        v ? LanguageCodes.arabic : LanguageCodes.english,
                      ),
                    ),
                  ),
                  AppListTile(
                    icon: isDark
                        ? Icons.dark_mode_rounded
                        : Icons.light_mode_rounded,
                    title: l10n.themeDark,
                    subtitle: l10n.settingsTheme,
                    onTap: () => cubit.changeTheme(
                      isDark ? ThemeMode.light : ThemeMode.dark,
                    ),
                    trailing: AppSwitch(
                      value: isDark,
                      onChanged: (v) => cubit.changeTheme(
                        v ? ThemeMode.dark : ThemeMode.light,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
          _Section(
            title: l10n.settingsAccount,
            dividerIndent: _dividerIndent,
            children: [
              AppListTile(
                icon: Icons.lock_outline_rounded,
                title: l10n.accountSecurity,
                onTap: () {
                },
              ),
              const _SignOutTile(),
            ],
          ),
        ],
      ),
    );
  }
}

class _SignOutTile extends StatelessWidget {
  const _SignOutTile();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    final isLoading = context.select(
          (AuthCubit c) =>
      c.state.action == AuthAction.revokeSession &&
          c.state.status == RequestStatus.loading,
    );

    return AppListTile(
      icon: Icons.logout_rounded,
      title: S.of(context).authLogOut,
      isDestructive: true,
      showChevron: false,
      onTap: isLoading ? null : () => context.read<AuthCubit>().logout(),
      trailing: isLoading
          ? SizedBox(
        width: Dimens.iconMd - Dimens.xs,
        height: Dimens.iconMd - Dimens.xs,
        child: CircularProgressIndicator(
          strokeWidth: Dimens.xxs,
          color: scheme.error,
        ),
      )
          : null,
    );
  }
}

class _FlagBadge extends StatelessWidget {
  const _FlagBadge({required this.isArabic});

  final bool isArabic;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Container(
      width: Dimens.iconLg,
      height: Dimens.iconLg,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: Dimens.borderMd,
        border: Border.all(color: scheme.outlineVariant),
      ),
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
    );
  }
}

class _ProfileCard extends StatelessWidget {
  const _ProfileCard({
    required this.session,
    required this.onEdit,
    required this.editTooltip,
  });

  final AuthSession? session;
  final VoidCallback onEdit;
  final String editTooltip;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;

    final fullName =
    '${session?.firstName ?? ''} ${session?.lastName ?? ''}'.trim();

    return AppCard(
      onTap: onEdit,
      child: Row(
        children: [
          _Avatar(url: session?.profilePictureUrl, name: fullName),
          Dimens.gapMd,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  fullName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: text.titleSmall,
                ),
                const SizedBox(height: Dimens.xxs),
                Text(
                  session?.email ?? '',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: text.bodySmall?.copyWith(
                    color: scheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          Dimens.gapSm,
          AppIconButton(
            icon: Icons.edit_outlined,
            tooltip: editTooltip,
            onPressed: onEdit,
          ),
        ],
      ),
    );
  }
}


class _Avatar extends StatelessWidget {
  const _Avatar({required this.url, required this.name});

  final String? url;
  final String name;

  static const double _size = Dimens.xxxl + Dimens.sm;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final hasImage = url != null && url!.trim().isNotEmpty;

    if (hasImage) {
      return ClipOval(
        child: AppNetworkImage(url: url, width: _size, height: _size),
      );
    }

    final initial = name.isEmpty ? '?' : name.characters.first.toUpperCase();

    return Container(
      width: _size,
      height: _size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: scheme.primaryContainer,
        shape: BoxShape.circle,
      ),
      child: Text(
        initial,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
          color: scheme.onPrimaryContainer,
        ),
      ),
    );
  }
}
class _Section extends StatelessWidget {
  const _Section({
    required this.title,
    required this.children,
    required this.dividerIndent,
  });

  final String title;
  final List<Widget> children;
  final double dividerIndent;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isArabic = Localizations.localeOf(context).languageCode ==
        LanguageCodes.ar;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsetsDirectional.only(
            start: Dimens.sm,
            top: Dimens.lg,
            bottom: Dimens.sm,
          ),
          child: Text(
            isArabic ? title : title.toUpperCase(),
            style: theme.textTheme.labelMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
              fontWeight: FontWeight.w600,
              letterSpacing: isArabic ? 0 : 0.8,
            ),
          ),
        ),
        AppCard(
          padding: const EdgeInsetsDirectional.symmetric(vertical: Dimens.xs),
          child: Column(
            children: [
              for (var i = 0; i < children.length; i++) ...[
                if (i > 0) Divider(indent: dividerIndent),
                children[i],
              ],
            ],
          ),
        ),
      ],
    );
  }
}