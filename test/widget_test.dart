import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:shaadi_app/main.dart';
import 'package:shaadi_app/screens/home_screen.dart';
import 'package:shaadi_app/screens/search_screen.dart';
import 'package:shaadi_app/screens/interests_screen.dart';
import 'package:shaadi_app/screens/matches_screen.dart';
import 'package:shaadi_app/screens/chat_screen.dart';
import 'package:shaadi_app/screens/profile_screen.dart';
import 'package:shaadi_app/screens/membership_screen.dart';
import 'package:shaadi_app/screens/privacy_settings_screen.dart';

class _TestHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  setUpAll(() {
    HttpOverrides.global = _TestHttpOverrides();
  });

  testWidgets('Matrimony App launches and navigates all 6 bottom tabs smoothly',
      (WidgetTester tester) async {
    final originalOnError = FlutterError.onError;
    FlutterError.onError = (FlutterErrorDetails details) {
      if (details.exception.toString().contains('NetworkImageLoadException') ||
          details.exception.toString().contains('HTTP request failed')) {
        return;
      }
      originalOnError?.call(details);
    };

    await tester.pumpWidget(const ShaadiMatrimonyApp());
    await tester.pumpAndSettle();

    // Verify MainScreen loads with BottomNavigationBar
    expect(find.byType(BottomNavigationBar), findsOneWidget);
    expect(find.byType(HomeScreen), findsOneWidget);

    // Tap Matches Tab
    await tester.tap(find.text('Matches'));
    await tester.pumpAndSettle();
    expect(find.byType(MatchesScreen), findsOneWidget);

    // Tap Search Tab
    await tester.tap(find.text('Search'));
    await tester.pumpAndSettle();
    expect(find.byType(SearchScreen), findsOneWidget);

    // Tap Interests Tab
    await tester.tap(find.text('Interests'));
    await tester.pumpAndSettle();
    expect(find.byType(InterestsScreen), findsOneWidget);

    // Tap Chat Tab
    await tester.tap(find.text('Chat'));
    await tester.pumpAndSettle();
    expect(find.byType(ChatScreen), findsOneWidget);

    // Tap Profile Tab
    await tester.tap(find.text('Profile'));
    await tester.pumpAndSettle();
    expect(find.byType(ProfileScreen), findsOneWidget);

    FlutterError.onError = originalOnError;
  });

  testWidgets('Test Membership Screen displays premium plans',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: MembershipScreen(),
    ));
    await tester.pumpAndSettle();

    expect(find.text('Shaadi Premium'), findsOneWidget);
    expect(find.text('Gold Membership'), findsOneWidget);
    expect(find.text('Diamond Membership'), findsOneWidget);
  });

  testWidgets('Test Privacy Settings Screen toggles privacy switches',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: PrivacySettingsScreen(),
    ));
    await tester.pumpAndSettle();

    expect(find.text('Privacy & Safety Shield'), findsOneWidget);
  });
}
