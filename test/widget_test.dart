import 'package:flutter_test/flutter_test.dart';
import 'package:spotify_clone/main.dart';

void main() {
  testWidgets('MyApp displays Hello World', (WidgetTester tester) async {
    // アプリをウィジェットツリーに追加
    await tester.pumpWidget(const MyApp());
    await tester.pump(const Duration(seconds: 2));
  });
}
