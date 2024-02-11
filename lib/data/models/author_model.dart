import 'package:equatable/equatable.dart';

import '../../domain/entities/author.dart';

class AuthorModel extends Equatable {
  final String name;
  final String image;

  const AuthorModel({
    required this.name,
    required this.image,
  });

  AuthorModel.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        image = json['image'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'image': image,
      };

  AuthorModel.fromAuthor(Author author)
      : name = author.name,
        image = author.image;

  Author toAuthor() => Author(
        name: name,
        image: image,
      );

  @override
  List<Object> get props => [name, image];

  @override
  bool get stringify => true;
}
