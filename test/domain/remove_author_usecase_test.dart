import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:stories_characters/domain/entities/author.dart';
import 'package:stories_characters/domain/repositories/authors_repository.dart';
import 'package:stories_characters/domain/usecases/remove_author_usecase.dart';

class MockAuthorsRepository extends Mock implements AuthorsRepository {}

void main() {
  group("RemoveAuthorUseCase", () {
    late RemoveAuthorUseCase removeAuthorUseCase;

    late AuthorsRepository authorsRepository;

    const author = Author(name: "name", image: "image");

    setUp(() {
      authorsRepository = MockAuthorsRepository();
      removeAuthorUseCase =
          RemoveAuthorUseCase(authorsRepository: authorsRepository);
    });

    test("should return true to remove an author", () async {
      const expected = Left(true);

      when(() => authorsRepository.removeAuthor(author))
          .thenAnswer((invocation) => Future.value(const Left(true)));

      final result = await removeAuthorUseCase(author);

      expect(result, expected);
      verify(() => authorsRepository.removeAuthor(author)).called(1);
    });
  });
}
