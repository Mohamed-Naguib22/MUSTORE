enum Gender {
  male('Male'),
  female('Female');

  const Gender(this.value);
  final String value;

  static Gender fromJson(String value) => Gender.values.firstWhere(
        (e) => e.value.toLowerCase() == value.toLowerCase(),
    orElse: () => throw FormatException('Unknown gender: $value'),
  );

  String toJson() => value;
}