enum LoginProvider { internal, google, microsoft, outlook }

extension LoginProviderX on LoginProvider {
  String get value => switch (this) {
    LoginProvider.internal => 'Internal',
    LoginProvider.google => 'Google',
    LoginProvider.microsoft => 'Microsoft',
    LoginProvider.outlook => 'Outlook',
  };

  static LoginProvider fromJson(String value) =>
      LoginProvider.values.firstWhere(
            (e) => e.value.toLowerCase() == value.toLowerCase(),
        orElse: () => throw FormatException('Unknown LoginProvider: $value'),
      );
}