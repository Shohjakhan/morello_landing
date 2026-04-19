import 'package:flutter_test/flutter_test.dart';
import 'package:chontak_landing/main.dart';
import 'package:chontak_landing/src/presentation/widgets/navbar/navbar.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const ChontakApp());

    // Verify that our Navbar is rendered.
    expect(find.byType(Navbar), findsOneWidget);
  });
}
