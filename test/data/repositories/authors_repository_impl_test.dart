import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:stories_characters/data/datasources/authors_datasource.dart';
import 'package:stories_characters/data/models/author_model.dart';
import 'package:stories_characters/data/respositories/authors_repository_impl.dart';
import 'package:stories_characters/domain/entities/author.dart';

class MockAuthorsDatasource extends Mock implements AuthorsDatasource {}

void main() {
  group("AuthorsRepositoryImpl", () {
    late AuthorsRepositoryImpl authorsRepository;

    late AuthorsDatasource authorsDatasource;

    const author = Author(name: "name", image: "image");
    const authorModel = AuthorModel(name: "name", image: "image");

    setUp(() {
      authorsDatasource = MockAuthorsDatasource();
      authorsRepository =
          AuthorsRepositoryImpl(authorsDatasource: authorsDatasource);
    });

    test("should add an author", () async {
      const expected = Left(true);

      when(() => authorsDatasource.addAuthor(authorModel))
          .thenAnswer((invocation) => Future.value(true));

      final result = await authorsRepository.addAuthor(author);

      expect(result, expected);
      verify(() => authorsDatasource.addAuthor(authorModel)).called(1);
    });

    test("should remove an author", () async {
      const expected = Left(true);

      when(() => authorsDatasource.removeAuthor(authorModel))
          .thenAnswer((invocation) => Future.value(true));

      final result = await authorsRepository.removeAuthor(author);

      expect(result, expected);
      verify(() => authorsDatasource.removeAuthor(authorModel)).called(1);
    });

    test("should return all authors", () async {
      const expected = Left(<Author>[author]);

      when(() => authorsDatasource.getAuthors())
          .thenAnswer((invocation) => Future.value(<AuthorModel>[authorModel]));

      final result = await authorsRepository.getAuthors();

      expect(result.isLeft, expected.isLeft);
      expect(result.left, expected.left);
      verify(() => authorsDatasource.getAuthors()).called(1);
    });
  });
}
