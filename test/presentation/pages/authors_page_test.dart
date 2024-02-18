import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stories_characters/presentation/pages/authors_page.dart';

void main() {
  group("AuthorsPage", () {
    Future<void> createWidget(WidgetTester tester) async {
      return tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: AuthorsPage(),
            ),
          ),
        ),
      );
    }

    testWidgets('show display title', (WidgetTester tester) async {
      await createWidget(tester);

      expect(find.text('Authors'), findsOneWidget);
    });
  });
}
