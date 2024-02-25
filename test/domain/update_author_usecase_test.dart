import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:stories_characters/domain/entities/author.dart';
import 'package:stories_characters/domain/repositories/authors_repository.dart';
import 'package:stories_characters/domain/usecases/update_author_usecase.dart';

class MockAuthorsRepository extends Mock implements AuthorsRepository {}

void main() {
  group("UpdateAuthorUseCase", () {
    late UpdateAuthorUseCase updateAuthorUseCase;

    late AuthorsRepository authorsRepository;

    const author = Author(id: "1234", name: "name", image: "image");

    setUp(() {
      authorsRepository = MockAuthorsRepository();
      updateAuthorUseCase = UpdateAuthorUseCase(authorsRepository: authorsRepository);
    });

    test("should return true for updating an author", () async {
      const expected = Right(true);

      when(() => authorsRepository.updateAuthor(author))
          .thenAnswer((invocation) => Future.value(const Right(true)));

      final result = await updateAuthorUseCase(author);

      expect(result, expected);
      verify(() => authorsRepository.updateAuthor(author)).called(1);
    });
  });
}
