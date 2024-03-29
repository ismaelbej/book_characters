import 'dart:convert';

import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

import '../../models/author_model.dart';
import '../authors_datasource.dart';

class LocalAuthorsDatasource implements AuthorsDatasource {
  late final Future<StreamingSharedPreferences> sharedPreferences;
  late final Future<Preference<List<AuthorModel>>> _authorsPreference;

  Future<List<AuthorModel>> get authors =>
      _authorsPreference.then((preference) => preference.getValue());

  static const authorsKey = "authors";
  static final authorsListAdapter = JsonAdapter<List<AuthorModel>>(
    deserializer: (json) => (json as List)
        .map((json) => AuthorModel.fromJson(jsonDecode(json)))
        .toList(),
    serializer: (authors) =>
        authors.map((author) => jsonEncode(author.toJson())).toList(),
  );

  LocalAuthorsDatasource({required this.sharedPreferences}) {
    init();
  }

  void init() {
    _authorsPreference = sharedPreferences.then(
      (preferences) => preferences.getCustomValue(
        authorsKey,
        defaultValue: <AuthorModel>[],
        adapter: authorsListAdapter,
      ),
    );
  }

  @override
  Future<bool> addAuthor(AuthorModel author) async {
    return authors.then(
      (authors) => _authorsPreference.then(
        (authorsPreference) => authorsPreference.setValue(
          [...authors, author],
        ),
      ),
    );
  }

  @override
  Future<bool> removeAuthor(AuthorModel author) async {
    return authors.then(
      (authors) => _authorsPreference.then(
        (authorsPreference) => authorsPreference.setValue(
          List<AuthorModel>.of(authors)..remove(author),
        ),
      ),
    );
  }

  @override
  Future<bool> updateAuthor(AuthorModel author) async {
    final result = authors.then(
      (authors) => _authorsPreference.then(
        (authorsPreference) => authorsPreference.setValue(
          authors
              .map(
                (model) => model.id == author.id ? author : model,
              )
              .toList(),
        ),
      ),
    );

    return result;
  }

  @override
  Future<List<AuthorModel>> getAuthors() async {
    return authors;
  }
}
