import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/author.dart';
import '../../services/providers.dart';
import 'authors_page_state.dart';

class AuthorsPageController extends AsyncNotifier<AuthorsPageState> {
  AuthorsPageController();

  @override
  FutureOr<AuthorsPageState> build() {
    return const AuthorsPageState(authors: <Author>[]);
  }

  Future<void> getAuthors() async {
    final getAuthorsUseCase = ref.read(getAuthorsUseCaseProvider);

    state = const AsyncLoading();

    final result = await getAuthorsUseCase();

    state = result.fold(
      (authors) => AsyncValue.data(AuthorsPageState(authors: authors)),
      (exception) => AsyncValue.error(exception, StackTrace.current),
    );
  }

  Future<void> addAuthor(Author author) async {
    final getAuthorsUseCase = ref.read(getAuthorsUseCaseProvider);
    final addAuthorUseCase = ref.read(addAuthorUseCaseProvider);

    final addResult = await addAuthorUseCase(author);
    addResult.fold(
      (added) async {
        state = const AsyncLoading();

        final result = await getAuthorsUseCase();

        state = result.fold(
          (authors) => AsyncValue.data(AuthorsPageState(authors: authors)),
          (exception) => AsyncValue.error(exception, StackTrace.current),
        );
      },
      (exception) {
        state = AsyncValue.error(exception, StackTrace.current);
      },
    );
  }

  Future<void> removeAuthor(Author author) async {
    final getAuthorsUseCase = ref.read(getAuthorsUseCaseProvider);
    final removeAuthorUseCase = ref.read(removeAuthorUseCaseProvider);

    final removeResult = await removeAuthorUseCase(author);
    removeResult.fold(
      (removed) async {
        state = const AsyncLoading();

        final result = await getAuthorsUseCase();

        state = result.fold(
          (authors) => AsyncValue.data(AuthorsPageState(authors: authors)),
          (exception) => AsyncValue.error(exception, StackTrace.current),
        );
      },
      (exception) {
        state = AsyncValue.error(exception, StackTrace.current);
      },
    );
  }
}
