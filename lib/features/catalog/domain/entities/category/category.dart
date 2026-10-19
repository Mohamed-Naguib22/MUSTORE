import 'package:equatable/equatable.dart';

class Category extends Equatable {
  final String id;
  final String name;
  final String imageUrl;

  const Category({
    required this.id,
    required this.name,
    required this.imageUrl,
  });

  const Category.fake({int index = 0})
      : id = 'placeholder_$index',
        name = 'Category placeholder name',
        imageUrl = '';

  static List<Category> fakeList([int count = 6]) =>
      List.generate(count, (i) => Category.fake(index: i));

  @override
  List<Object?> get props => [
    id,
    name,
    imageUrl,
  ];
}