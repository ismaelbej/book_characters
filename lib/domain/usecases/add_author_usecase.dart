import 'package:either_dart/either.dart';

import '../../core/failure.dart';
import '../entities/author.dart';
import '../repositories/authors_repository.dart';

class AddAuthorUseCase {
  final AuthorsRepository authorsRepository;

  AddAuthorUseCase({required this.authorsRepository});

  Future<Either<Failure, bool>> call(Author author) async {
    return authorsRepository.addAuthor(author);
  }
}
