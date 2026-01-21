import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:journeyman_jobs/design_system/electrical/circuit_board_background.dart';

void main() {
  testWidgets('ElectricalCircuitBackground renders without errors',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: ElectricalCircuitBackground(
            opacity: 0.5,
            animationSpeed: 1.0,
          ),
        ),
      ),
    );

    expect(find.byType(ElectricalCircuitBackground), findsOneWidget);

    // Allow animations to run a bit
    await tester.pump(const Duration(milliseconds: 100));
    await tester.pump(const Duration(milliseconds: 100));
  });
}
