import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:stories_characters/domain/entities/author.dart';
import 'package:stories_characters/domain/repositories/authors_repository.dart';
import 'package:stories_characters/domain/usecases/add_author_usecase.dart';

class MockAuthorsRepository extends Mock implements AuthorsRepository {}

void main() {
  group("AddAuthorUseCase", () {
    late AddAuthorUseCase addAuthorUseCase;

    late AuthorsRepository authorsRepository;

    const author = Author(name: "name", image: "image");

    setUp(() {
      authorsRepository = MockAuthorsRepository();
      addAuthorUseCase = AddAuthorUseCase(authorsRepository: authorsRepository);
    });

    test("should return true for adding a new author", () async {
      const expected = Left(true);

      when(() => authorsRepository.addAuthor(author))
          .thenAnswer((invocation) => Future.value(const Left(true)));

      final result = await addAuthorUseCase(author);

      expect(result, expected);
      verify(() => authorsRepository.addAuthor(author)).called(1);
    });
  });
}
