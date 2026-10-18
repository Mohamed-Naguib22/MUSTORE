enum Gender { male, female, }

extension GenderX on Gender {
  String get value => switch (this) {
    Gender.male => 'Male',
    Gender.female => 'Female',
  };

  static Gender fromJson(String value) => Gender.values.firstWhere(
        (e) => e.value.toLowerCase() == value.toLowerCase(),
    orElse: () => throw FormatException('Unknown Gender: $value'),
  );
}