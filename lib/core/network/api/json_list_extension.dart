extension JsonListX on List<dynamic> {
  List<T> toModels<T>(T Function(Map<String, dynamic> json) fromJson) =>
      map((e) => fromJson(e as Map<String, dynamic>)).toList();
}