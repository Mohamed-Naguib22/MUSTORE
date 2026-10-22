import 'package:mustore/features/lookup/domain/entities/lookup.dart';

class LookupModel extends Lookup {
  const LookupModel({
    required super.id,
    required super.name,
  });

  factory LookupModel.fromJson(Map<String, dynamic> json) {
    return LookupModel(
      id: json['id'] as String,
      name: json['name'] as String,
    );
  }

  static List<LookupModel> listFromJson(List<dynamic> json) {
    return json
        .map((e) => LookupModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}