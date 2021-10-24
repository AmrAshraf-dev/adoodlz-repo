import 'package:flutter_test/flutter_test.dart';
import 'package:adoodlz/main.dart';

void main() {
  testWidgets('Test localization title in appbar', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());
    await tester.pumpAndSettle();

    final titleFinder = find.text('Hello Adoodlz!');
    final arTitleFinder = find.text('مرحباً, آدوودلز');

    expect(titleFinder, findsNothing);
    expect(arTitleFinder, findsOneWidget);
  });
}
