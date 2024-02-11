import 'package:equatable/equatable.dart';

class Author extends Equatable {
  final String name;
  final String image;

  const Author({
    required this.name,
    required this.image,
  });

  @override
  List<Object> get props => [name, image];

  @override
  bool get stringify => true;
}
