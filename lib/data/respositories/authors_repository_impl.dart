import 'package:either_dart/either.dart';

import '../datasources/authors_datasource.dart';
import '../models/author_model.dart';
import '../../domain/entities/author.dart';
import '../../domain/repositories/authors_repository.dart';

class AuthorsRepositoryImpl implements AuthorsRepository {
  const AuthorsRepositoryImpl({required this.authorsDatasource});

  final AuthorsDatasource authorsDatasource;

  @override
  Future<Either<List<Author>, Exception>> getAuthors() async {
    try {
      final authors = await authorsDatasource.getAuthors();
      return Left(authors.map((model) => model.toAuthor()).toList());
    } on Exception catch (ex) {
      return Right(ex);
    }
  }

  @override
  Future<Either<bool, Exception>> addAuthor(Author author) async {
    try {
      final result =
          await authorsDatasource.addAuthor(AuthorModel.fromAuthor(author));
      return Left(result);
    } on Exception catch (ex) {
      return Right(ex);
    }
  }

  @override
  Future<Either<bool, Exception>> removeAuthor(Author author) async {
    try {
      final result =
          await authorsDatasource.removeAuthor(AuthorModel.fromAuthor(author));
      return Left(result);
    } on Exception catch (ex) {
      return Right(ex);
    }
  }
}
