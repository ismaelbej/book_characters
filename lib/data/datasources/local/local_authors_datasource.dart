import 'dart:convert';

import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

import '../../models/author_model.dart';
import '../authors_datasource.dart';

class LocalAuthorsDatasource implements AuthorsDatasource {
  late final Future<StreamingSharedPreferences> sharedPreferences;
  late final Preference<List<AuthorModel>> _authors;

  List<AuthorModel> get authors => _authors.getValue();

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

  void init() async {
    final sharedPreferences = await this.sharedPreferences;
    _authors = sharedPreferences.getCustomValue(
      authorsKey,
      defaultValue: <AuthorModel>[],
      adapter: authorsListAdapter,
    );
  }

  @override
  Future<bool> addAuthor(AuthorModel author) async {
    return _authors.setValue(List<AuthorModel>.of(authors)..add(author));
  }

  @override
  Future<List<AuthorModel>> getAuthors() async {
    return authors;
  }

  @override
  Future<bool> removeAuthor(AuthorModel author) async {
    return _authors.setValue(List<AuthorModel>.of(authors)..remove(author));
  }
}
