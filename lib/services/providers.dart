import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

import '../data/datasources/authors_datasource.dart';
import '../data/datasources/local/local_authors_datasource.dart';
import '../data/respositories/authors_repository_impl.dart';
import '../domain/repositories/authors_repository.dart';
import '../domain/usecases/get_authors_usecase.dart';
import '../domain/usecases/add_author_usecase.dart';
import '../domain/usecases/new_author_usecase.dart';
import '../domain/usecases/remove_author_usecase.dart';
import '../domain/usecases/update_author_usecase.dart';

final streamingSharedPreferencesProvider =
    Provider<Future<StreamingSharedPreferences>>((ref) {
  return StreamingSharedPreferences.instance;
});

final authorsDatasourceProvider = Provider<AuthorsDatasource>((ref) {
  final streamingSharedPreferences =
      ref.read(streamingSharedPreferencesProvider);
  return LocalAuthorsDatasource(sharedPreferences: streamingSharedPreferences);
});

final authorsRepositoryProvider = Provider<AuthorsRepository>((ref) {
  final authorsDatasource = ref.read(authorsDatasourceProvider);
  return AuthorsRepositoryImpl(authorsDatasource: authorsDatasource);
});

final getAuthorsUseCaseProvider = Provider<GetAuthorsUseCase>((ref) {
  final authorsRepository = ref.read(authorsRepositoryProvider);
  return GetAuthorsUseCase(authorsRepository: authorsRepository);
});

final addAuthorUseCaseProvider = Provider<AddAuthorUseCase>((ref) {
  final authorsRepository = ref.read(authorsRepositoryProvider);
  return AddAuthorUseCase(authorsRepository: authorsRepository);
});

final removeAuthorUseCaseProvider = Provider<RemoveAuthorUseCase>((ref) {
  final authorsRepository = ref.read(authorsRepositoryProvider);
  return RemoveAuthorUseCase(authorsRepository: authorsRepository);
});

final updateAuthorUseCaseProvider = Provider<UpdateAuthorUseCase>((ref) {
  final authorsRepository = ref.read(authorsRepositoryProvider);
  return UpdateAuthorUseCase(authorsRepository: authorsRepository);
});

final newAuthorUseCaseProvider = Provider<NewAuthorUseCase>((ref) {
  return NewAuthorUseCase();
});
