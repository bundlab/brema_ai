import 'package:flutter_test/flutter_test.dart';
import 'package:brema_ai/main.dart';

void main() {
  testWidgets('BremaAI app launches successfully', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const BremaAI());

    expect(find.byType(BremaAI), findsOneWidget);
  });
}
