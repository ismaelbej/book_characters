import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/author.dart';
import '../../presentation/controllers.dart';

class AuthorsPage extends ConsumerWidget {
  const AuthorsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(authorsPageController);
    return Scaffold(
      body: state.when(
        data: (state) => ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return Text("${state.authors[index]}");
          },
          itemCount: state.authors.length,
        ),
        error: (error, _) => Text('$error'),
        loading: () => const CircularProgressIndicator(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          const author = Author(name: "hello", image: "image");

          ref.read(authorsPageController.notifier).addAuthor(author);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
