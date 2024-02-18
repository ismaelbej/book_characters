import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stories_characters/presentation/app.dart';
import 'package:stories_characters/presentation/pages/authors_page.dart';

void main() {
  testWidgets('show load author\'s page', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MyApp(),
      ),
    );

    expect(find.byType(AuthorsPage), findsOneWidget);
  });
}
