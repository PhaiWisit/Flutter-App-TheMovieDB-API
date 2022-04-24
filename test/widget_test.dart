import 'package:flutter/material.dart';
import 'package:flutter_moviedb_api/views/home_screen.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Tap BottomNevBar Test', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: HomeScreen(),
    ));

    await tester.tap(find.byIcon(Icons.home));
    await tester.pump();
    expect(find.text('home'), findsOneWidget);
    expect(find.text('หน้าหลัก '), findsNothing);

    await tester.tap(find.byIcon(Icons.movie));
    await tester.pump();
    expect(find.text('movie'), findsOneWidget);
    expect(find.text('home'), findsNothing);

    await tester.tap(find.byIcon(Icons.live_tv_outlined));
    await tester.pump();
    expect(find.text('series'), findsOneWidget);
    expect(find.text('movie'), findsNothing);

    await tester.tap(find.byIcon(Icons.favorite));
    await tester.pump();
    expect(find.text('favorite'), findsOneWidget);
    expect(find.text('series'), findsNothing);
  });

  testWidgets('Tap search Test', (WidgetTester tester) async {
    // await tester.pumpWidget(const MaterialApp(
    //   home: HomeScreen(),
    // ));

    // await tester.tap(find.byIcon(Icons.search));
    // await tester.pump();
  });
}
