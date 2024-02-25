import 'dart:async';

import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/failure.dart';
import '../../../domain/entities/author.dart';
import '../../../services/providers.dart';
import 'authors_state.dart';

class AuthorsController extends AsyncNotifier<AuthorsState> {
  AuthorsController();

  @override
  FutureOr<AuthorsState> build() async {
    final result = await _fetchAuthors();
    return result.fold(
      (failure) => const AuthorsState(authors: <Author>[]),
      (authors) => AuthorsState(authors: authors),
    );
  }

  Future<void> getAuthors() async {
    state = const AsyncLoading();
    state = await _fetchAuthors().fold(
      (failure) => AsyncValue.error(failure, StackTrace.current),
      (authors) => AsyncValue.data(AuthorsState(authors: authors)),
    );
  }

  Future<bool> addAuthor(Author author) async {
    final addAuthorUseCase = ref.read(addAuthorUseCaseProvider);

    state = await addAuthorUseCase(
      author,
    ).thenRight(
      (added) {
        state = const AsyncLoading();
        return _fetchAuthors();
      },
    ).fold(
      (failure) => AsyncValue.error(failure, StackTrace.current),
      (authors) => AsyncValue.data(AuthorsState(authors: authors)),
    );

    return !state.hasError;
  }

  Future<bool> removeAuthor(Author author) async {
    final removeAuthorUseCase = ref.read(removeAuthorUseCaseProvider);

    state = await removeAuthorUseCase(
      author,
    ).thenRight(
      (added) {
        state = const AsyncLoading();
        return _fetchAuthors();
      },
    ).fold(
      (failure) => AsyncValue.error(failure, StackTrace.current),
      (authors) => AsyncValue.data(AuthorsState(authors: authors)),
    );

    return !state.hasError;
  }

  Future<bool> updateAuthor(Author author) async {
    final updateAuthorUseCase = ref.read(updateAuthorUseCaseProvider);

    state = await updateAuthorUseCase(
      author,
    ).thenRight(
      (added) {
        state = const AsyncLoading();
        return _fetchAuthors();
      },
    ).fold(
      (failure) => AsyncValue.error(failure, StackTrace.current),
      (authors) => AsyncValue.data(AuthorsState(authors: authors)),
    );

    return !state.hasError;
  }

  Future<Either<Failure, List<Author>>> _fetchAuthors() {
    final getAuthorsUseCase = ref.read(getAuthorsUseCaseProvider);
    return getAuthorsUseCase();
  }

  Author newAuthor() {
    final newAuthorUseCase = ref.read(newAuthorUseCaseProvider);
    return newAuthorUseCase();
  }
}
