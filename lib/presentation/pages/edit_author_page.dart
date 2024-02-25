import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/author.dart';
import '../controllers/controllers.dart';

class EditAuthorPage extends ConsumerStatefulWidget {
  final Author? author;
  const EditAuthorPage({super.key, this.author});

  @override
  ConsumerState<EditAuthorPage> createState() => _EditAuthorPageState();
}

class _EditAuthorPageState extends ConsumerState<EditAuthorPage> {
  final _formKey = GlobalKey<FormState>();

  late Author _author;

  final nameController = TextEditingController();

  @override
  void initState() {
    _author =
        widget.author ?? ref.read(authorsPageController.notifier).newAuthor();
    nameController.text = _author.name;
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.author != null ? 'Edit' : 'New'} Author"),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
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
                          "",
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox.square(dimension: 16.0),
                  Expanded(
                    child: TextFormField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Name',
                      ),
                      style: Theme.of(context).textTheme.displayMedium,
                      onChanged: (name) {
                        _author = _author.copyWith(name: name);
                      },
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () async {
                    final result = await ((widget.author == null)
                        ? ref
                            .read(authorsPageController.notifier)
                            .addAuthor(_author)
                        : ref
                            .read(authorsPageController.notifier)
                            .updateAuthor(_author));
                    if (result) {
                      if (!context.mounted) return;
                      Navigator.of(context).pop();
                    }
                  },
                  child: const Text('Save'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
