import 'package:either_dart/either.dart';

import '../../core/failure.dart';
import '../../domain/entities/author.dart';
import '../../domain/repositories/authors_repository.dart';
import '../datasources/authors_datasource.dart';
import '../models/author_model.dart';

class AuthorsRepositoryImpl implements AuthorsRepository {
  const AuthorsRepositoryImpl({required this.authorsDatasource});

  final AuthorsDatasource authorsDatasource;

  @override
  Future<Either<Failure, List<Author>>> getAuthors() async {
    try {
      final authors = await authorsDatasource.getAuthors();
      return Right(authors.map((model) => model.toAuthor()).toList());
    } on Exception catch (ex) {
      return Left(Failure(ex.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> addAuthor(Author author) async {
    try {
      final result =
          await authorsDatasource.addAuthor(AuthorModel.fromAuthor(author));
      return Right(result);
    } on Exception catch (ex) {
      return Left(Failure(ex.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> removeAuthor(Author author) async {
    try {
      final result =
          await authorsDatasource.removeAuthor(AuthorModel.fromAuthor(author));
      return Right(result);
    } on Exception catch (ex) {
      return Left(Failure(ex.toString()));
    }
  }
}
