import 'package:either_dart/either.dart';

import '../entities/author.dart';
import '../repositories/authors_repository.dart';

class RemoveAuthorUseCase {
  final AuthorsRepository authorsRepository;

  RemoveAuthorUseCase({required this.authorsRepository});

  Future<Either<bool, Exception>> call(Author author) async {
    return authorsRepository.removeAuthor(author);
  }
}
