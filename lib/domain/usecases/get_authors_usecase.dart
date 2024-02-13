import 'package:either_dart/either.dart';

import '../entities/author.dart';
import '../repositories/authors_repository.dart';

class GetAuthorsUseCase {
  final AuthorsRepository authorsRepository;

  GetAuthorsUseCase({required this.authorsRepository});

  Future<Either<List<Author>, Exception>> call() async {
    return authorsRepository.getAuthors();
  }
}
