import 'package:flutter/material.dart';

import '../../domain/entities/author.dart';
import 'edit_author_page.dart';

class AuthorPage extends StatelessWidget {
  final Author author;

  const AuthorPage({super.key, required this.author});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(author.name.isEmpty ? "Author" : author.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                SizedBox.square(
                  dimension: 96,
                  child: Center(
                    child: CircleAvatar(
                      radius: 32,
                      backgroundColor: Colors.lightBlue[100],
                      child: Text(
                        author.name[0].toUpperCase(),
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                    ),
                  ),
                ),
                const SizedBox.square(dimension: 16.0),
                Expanded(
                  child: Text(
                    author.name,
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => EditAuthorPage(author: author),
            ),
          );
        },
        child: const Icon(Icons.edit),
      ),
    );
  }
}
