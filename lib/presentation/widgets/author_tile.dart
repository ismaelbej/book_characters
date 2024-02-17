import 'package:flutter/material.dart';

import '../../domain/entities/author.dart';

class AuthorTile extends StatelessWidget {
  final Author author;

  const AuthorTile({super.key, required this.author});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.lightBlue[100],
        child: Text(author.name[0].toUpperCase()),
      ),
      title: Text(
        author.name,
        style: Theme.of(context).textTheme.titleLarge,
      ),
      subtitle: Text(
        "author",
        style: Theme.of(context).textTheme.titleSmall,
      ),
      trailing: const Icon(Icons.chevron_right),
    );
  }
}
