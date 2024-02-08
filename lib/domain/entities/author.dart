import 'package:equatable/equatable.dart';

class Author extends Equatable {
  final String name;
  final String bio;

  const Author({
    required this.name,
    required this.bio,
  });

  @override
  List<Object> get props => [name, bio];

  @override
  bool get stringify => true;
}
