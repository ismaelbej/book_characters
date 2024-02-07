import 'package:either_dart/either.dart';

import '../entities/author.dart';

abstract class AuthorsRepository {
  Future<Either<List<Author>, Exception>> getAuthors();
  Future<Either<bool, Exception>> addAuthor(Author author);
  Future<Either<bool, Exception>> removeAuthor(Author author);
}
