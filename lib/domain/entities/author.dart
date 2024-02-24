import 'package:equatable/equatable.dart';

class Author extends Equatable {
  final String id;
  final String name;
  final String image;

  const Author({
    required this.id,
    required this.name,
    required this.image,
  });

  @override
  List<Object> get props => [id, name, image];

  @override
  bool get stringify => true;
}
