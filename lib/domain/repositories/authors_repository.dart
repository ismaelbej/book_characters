import 'package:either_dart/either.dart';

import '../../core/failure.dart';
import '../entities/author.dart';

abstract class AuthorsRepository {
  Future<Either<Failure, List<Author>>> getAuthors();

  Future<Either<Failure, bool>> addAuthor(Author author);

  Future<Either<Failure, bool>> removeAuthor(Author author);
}
