import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controllers/controllers.dart';
import '../widgets/author_tile.dart';
import 'author_page.dart';
import 'edit_author_page.dart';

class AuthorsPage extends ConsumerWidget {
  const AuthorsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(authorsPageController);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Authors"),
      ),
      body: state.when(
        data: (state) => ListView.builder(
          itemBuilder: (BuildContext context, int index) => InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      AuthorPage(author: state.authors[index]),
                ),
              );
            },
            child: Dismissible(
              key: ValueKey(state.authors[index]),
              onDismissed: (direction) {
                ref
                    .read(authorsPageController.notifier)
                    .removeAuthor(state.authors[index]);
              },
              child: AuthorTile(author: state.authors[index]),
            ),
          ),
          itemCount: state.authors.length,
        ),
        error: (error, _) => Text('$error'),
        loading: () => const CircularProgressIndicator(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const EditAuthorPage(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
