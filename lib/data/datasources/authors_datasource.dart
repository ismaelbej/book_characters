import '../models/author_model.dart';

abstract class AuthorsDatasource {
  Future<List<AuthorModel>> getAuthors();
  Future<bool> addAuthor(AuthorModel author);
  Future<bool> removeAuthor(AuthorModel author);
}
