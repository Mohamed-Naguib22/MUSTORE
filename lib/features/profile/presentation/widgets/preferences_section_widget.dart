import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mustore/core/services/localization/language_codes.dart';
import 'package:mustore/core/widgets/inputs/app_switch.dart';
import 'package:mustore/core/widgets/lists/app_list_tile.dart';
import 'package:mustore/features/settings/presentation/controllers/settings_cubit.dart';
import 'package:mustore/features/settings/presentation/controllers/settings_state.dart';
import 'package:mustore/generated/l10n.dart';
import 'account_section_widget.dart';
import 'language_flag_badge_widget.dart';

class PreferencesSectionWidget extends StatelessWidget {
  const PreferencesSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);

    return BlocBuilder<SettingsCubit, SettingsState>(
      buildWhen: (p, c) => p.themeMode != c.themeMode || p.locale != c.locale,
      builder: (context, state) {
        final cubit = context.read<SettingsCubit>();
        final isDark = Theme.of(context).brightness == Brightness.dark;
        final isArabic =
            Localizations.localeOf(context).languageCode == LanguageCodes.ar;

        return AccountSectionWidget(
          title: l10n.accountPreferences,
          children: [
            AppListTile(
              leading: LanguageFlagBadgeWidget(isArabic: isArabic),
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
    );
  }
}