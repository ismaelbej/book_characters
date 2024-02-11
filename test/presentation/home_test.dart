import 'package:flutter_test/flutter_test.dart';
import 'package:stories_characters/presentation/app.dart';

void main() {
  testWidgets('show title', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Stories Characters'), findsOneWidget);
  });
}
