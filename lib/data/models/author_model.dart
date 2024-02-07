import '../../domain/entities/author.dart';

class AuthorModel {
  final String name;
  final String bio;

  const AuthorModel({
    required this.name,
    required this.bio,
  });

  AuthorModel.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        bio = json['bio'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'bio': bio,
      };

  AuthorModel.fromAuthor(Author author)
      : name = author.name,
        bio = author.bio;

  Author toAuthor() => Author(
        name: name,
        bio: bio,
      );
}
