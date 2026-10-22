import 'package:equatable/equatable.dart';

class Lookup extends Equatable {
  final String id;
  final String name;

  const Lookup({
    required this.id,
    required this.name,
  });

  factory Lookup.fake({
    String id = '3fa85f64-5717-4562-b3fc-2c963f66afa6',
    String name = 'test',
  }) {
    return Lookup(id: id, name: name);
  }

  @override
  List<Object?> get props => [id, name];
}