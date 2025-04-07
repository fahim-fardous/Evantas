// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hello_flutter/presentation/app/app.dart';
import 'package:mocktail/mocktail.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class MockSupabaseClient extends Mock implements SupabaseClient {}

void main() {
  setUpAll(() async {
    // Load environment variables for the test environment
    await dotenv.load(fileName: '.env');
    print(dotenv.env['SUPABASE_URL']);  // Ensure .env file is loaded
    print(dotenv.env['SUPABASE_ANON_KEY']);
  });

  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Create mock Supabase client
    final mockClient = MockSupabaseClient();

    // Mock the Supabase client with the mock version
    Supabase.instance.client = mockClient;

    // Build the app and trigger a frame
    await tester.pumpWidget(MyApp());

    // Verify initial state of the app
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify the counter increments
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}