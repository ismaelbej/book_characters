import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stories_characters/domain/entities/author.dart';
import 'package:stories_characters/presentation/widgets/author_tile.dart';

void main() {
  group("AuthorTile", () {
    const author = Author(name: "name", image: "image");

    Future<void> createWidget(WidgetTester tester) async {
      return tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AuthorTile(author: author),
          ),
        ),
      );
    }

    testWidgets('show author\'s name', (WidgetTester tester) async {
      await createWidget(tester);

      expect(find.text(author.name), findsOneWidget);
    });

    testWidgets('show author\'s initial', (WidgetTester tester) async {
      await createWidget(tester);

      expect(find.text(author.name[0].toUpperCase()), findsOneWidget);
    });
  });
}
