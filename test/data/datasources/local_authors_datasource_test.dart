import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:stories_characters/data/datasources/local/local_authors_datasource.dart';
import 'package:stories_characters/data/models/author_model.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

class MockPreferenceAuthors extends Mock
    implements Preference<List<AuthorModel>> {}

class MockStreamingSharedPreferences extends Mock
    implements StreamingSharedPreferences {}

void main() {
  group("LocalAuthorsDatasource", () {
    late LocalAuthorsDatasource authorsDatasource;

    late StreamingSharedPreferences sharedPreferences;
    late MockPreferenceAuthors preferenceAuthors;

    const authorModel = AuthorModel(name: "name", bio: "bio");

    setUp(() {
      preferenceAuthors = MockPreferenceAuthors();
      sharedPreferences = MockStreamingSharedPreferences();
      when(
        () => sharedPreferences.getCustomValue(
          LocalAuthorsDatasource.authorsKey,
          defaultValue: <AuthorModel>[],
          adapter: LocalAuthorsDatasource.authorsListAdapter,
        ),
      ).thenAnswer((invocation) => preferenceAuthors);

      authorsDatasource =
          LocalAuthorsDatasource(sharedPreferences: sharedPreferences);
    });

    test("should add an author", () async {
      const expected = true;

      when(() => preferenceAuthors.getValue()).thenReturn([]);
      when(() => preferenceAuthors.setValue([authorModel]))
          .thenAnswer((invocation) => Future.value(true));

      final result = await authorsDatasource.addAuthor(authorModel);

      expect(result, expected);
      verify(() => preferenceAuthors.getValue()).called(2);
      verify(() => preferenceAuthors.setValue([authorModel])).called(1);
    });

    test("should remove an author", () async {
      const expected = true;

      when(() => preferenceAuthors.getValue()).thenReturn([authorModel]);
      when(() => preferenceAuthors.setValue([]))
          .thenAnswer((invocation) => Future.value(true));

      final result = await authorsDatasource.removeAuthor(authorModel);

      expect(result, expected);
      verify(() => preferenceAuthors.getValue()).called(2);
      verify(() => preferenceAuthors.setValue([])).called(1);
    });

    test("should return all authors", () async {
      const expected = [authorModel];

      when(() => preferenceAuthors.getValue()).thenReturn([authorModel]);

      final result = await authorsDatasource.getAuthors();

      expect(result, expected);
      verify(() => preferenceAuthors.getValue()).called(1);
    });
  });
}
