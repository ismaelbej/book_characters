import 'package:equatable/equatable.dart';

import '../../domain/entities/author.dart';

class AuthorModel extends Equatable {
  final String id;
  final String name;
  final String image;

  const AuthorModel({
    required this.id,
    required this.name,
    required this.image,
  });

  AuthorModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        image = json['image'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'image': image,
      };

  AuthorModel.fromAuthor(Author author)
      : id = author.id,
        name = author.name,
        image = author.image;

  Author toAuthor() => Author(
        id: id,
        name: name,
        image: image,
      );

  @override
  List<Object> get props => [id, name, image];

  @override
  bool get stringify => true;
}
