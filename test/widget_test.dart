import 'package:flutter_test/flutter_test.dart';
import 'package:practise_app/app.dart';
import 'package:practise_app/common/widgets/food_logo.dart';

void main() {
  testWidgets('App smoke test - loads SplashScreen and FoodLogo', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    expect(find.byType(FoodLogo), findsOneWidget);
  });
}
