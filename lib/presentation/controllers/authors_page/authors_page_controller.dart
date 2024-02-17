import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/entities/author.dart';
import '../../../services/providers.dart';
import 'authors_page_state.dart';

class AuthorsPageController extends AsyncNotifier<AuthorsPageState> {
  AuthorsPageController();

  @override
  FutureOr<AuthorsPageState> build() {
    return const AuthorsPageState(authors: <Author>[]);
  }

  Future<void> getAuthors() async {
    await _loadAuthors();
  }

  Future<void> _loadAuthors() async {
    final getAuthorsUseCase = ref.read(getAuthorsUseCaseProvider);

    state = const AsyncLoading();

    final result = await getAuthorsUseCase();

    state = result.fold(
      (failure) => AsyncValue.error(failure, StackTrace.current),
      (authors) => AsyncValue.data(AuthorsPageState(authors: authors)),
    );
  }

  Future<void> addAuthor(Author author) async {
    final addAuthorUseCase = ref.read(addAuthorUseCaseProvider);

    final addResult = await addAuthorUseCase(author);
    addResult.fold(
      (failure) {
        state = AsyncValue.error(failure, StackTrace.current);
      },
      (added) async {
        await _loadAuthors();
      },
    );
  }

  Future<void> removeAuthor(Author author) async {
    final removeAuthorUseCase = ref.read(removeAuthorUseCaseProvider);

    final removeResult = await removeAuthorUseCase(author);
    removeResult.fold(
      (failure) {
        state = AsyncValue.error(failure, StackTrace.current);
      },
      (removed) async {
        await _loadAuthors();
      },
    );
  }
}
