import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:stories_characters/domain/entities/author.dart';
import 'package:stories_characters/domain/repositories/authors_repository.dart';
import 'package:stories_characters/domain/usecases/get_authors_usecase.dart';

class MockAuthorsRepository extends Mock implements AuthorsRepository {}

void main() {
  group("GetAuthorsUseCase", () {
    late GetAuthorsUseCase getAuthorsUseCase;

    late AuthorsRepository authorsRepository;

    const author = Author(name: "name", image: "image");

    setUp(() {
      authorsRepository = MockAuthorsRepository();
      getAuthorsUseCase =
          GetAuthorsUseCase(authorsRepository: authorsRepository);
    });

    test("should return authors list", () async {
      const expected = Right(<Author>[author]);

      when(() => authorsRepository.getAuthors()).thenAnswer(
          (invocation) => Future.value(const Right(<Author>[author])));

      final result = await getAuthorsUseCase();

      expect(result, expected);
      verify(() => authorsRepository.getAuthors()).called(1);
    });
  });
}
