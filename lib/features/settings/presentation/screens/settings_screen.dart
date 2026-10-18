import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mustore/core/error/failure_message.dart';
import 'package:mustore/features/settings/presentation/controllers/settings_cubit.dart';
import 'package:mustore/features/settings/presentation/controllers/settings_state.dart';
import 'package:mustore/generated/l10n.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  static const _languageNames = {
    'en': 'English',
    'ar': 'العربية',
  };

  String _themeLabel(S l10n, ThemeMode mode) => switch (mode) {
    ThemeMode.system => l10n.themeSystem,
    ThemeMode.light => l10n.themeLight,
    ThemeMode.dark => l10n.themeDark,
  };

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);

    return BlocListener<SettingsCubit, SettingsState>(
      listenWhen: (p, c) => c.failure != null && p.failure != c.failure,
      listener: (context, state) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(content: Text(state.failure!.localizedMessage(context))),
          );
      },
      child: Scaffold(
        appBar: AppBar(title: Text(l10n.settings)),
        body: BlocBuilder<SettingsCubit, SettingsState>(
          buildWhen: (p, c) =>
          p.themeMode != c.themeMode || p.locale != c.locale,
          builder: (context, state) {
            final cubit = context.read<SettingsCubit>();

            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _Section(
                  title: l10n.settingsTheme,
                  children: [
                    for (final mode in ThemeMode.values)
                      _OptionTile(
                        title: _themeLabel(l10n, mode),
                        selected: state.themeMode == mode,
                        onTap: () => cubit.changeTheme(mode),
                      ),
                  ],
                ),
                const SizedBox(height: 24),
                _Section(
                  title: l10n.settingsLanguage,
                  children: [
                    _OptionTile(
                      title: l10n.languageSystem,
                      selected: state.locale == null,
                      onTap: () => cubit.changeLocale(null),
                    ),
                    for (final locale in S.delegate.supportedLocales)
                      _OptionTile(
                        title: _languageNames[locale.languageCode] ??
                            locale.languageCode,
                        selected:
                        state.locale?.languageCode == locale.languageCode,
                        onTap: () =>
                            cubit.changeLocale(Locale(locale.languageCode)),
                      ),
                  ],
                ),
              ],
            );
          },
        ),
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
          padding: const EdgeInsetsDirectional.only(start: 4, bottom: 8),
          child: Text(
            title,
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
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(color: cs.outline),
          ),
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

class _OptionTile extends StatelessWidget {
  const _OptionTile({
    required this.title,
    required this.selected,
    required this.onTap,
  });

  final String title;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return ListTile(
      onTap: onTap,
      selected: selected,
      selectedColor: cs.primary,
      textColor: cs.onSurface,
      title: Text(
        title,
        style: TextStyle(
          fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
        ),
      ),
      trailing: selected ? Icon(Icons.check_rounded, color: cs.primary) : null,
    );
  }
}