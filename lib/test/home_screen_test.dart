import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:item_tracker/providers/item_provider.dart';

import '../screens/home_screen.dart';

void main() {
  testWidgets('Add item workflow', (WidgetTester tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => ItemProvider(),
        child: MaterialApp(home: HomeScreen()),
      ),
    );

    expect(find.byType(ListTile), findsNothing);

    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField).at(0), 'New Item');
    await tester.enterText(find.byType(TextField).at(1), 'Item Description');
    await tester.tap(find.text('Add'));
    await tester.pumpAndSettle();

    expect(find.byType(ListTile), findsOneWidget);
  });
}
