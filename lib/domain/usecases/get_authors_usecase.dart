import 'package:either_dart/either.dart';

import '../../core/failure.dart';
import '../entities/author.dart';
import '../repositories/authors_repository.dart';

class GetAuthorsUseCase {
  final AuthorsRepository authorsRepository;

  GetAuthorsUseCase({required this.authorsRepository});

  Future<Either<Failure, List<Author>>> call() async {
    return authorsRepository.getAuthors();
  }
}
