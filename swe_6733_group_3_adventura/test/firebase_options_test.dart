import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() {
  group('DefaultFirebaseOptions Tests', () {
    test('web platform returns web options', () {
      debugDefaultTargetPlatformOverride = null;
      // Simulate web platform
      if (kIsWeb) {
        expect(DefaultFirebaseOptions.currentPlatform, equals(DefaultFirebaseOptions.web));
      }
    });

    test('android platform returns android options', () {
      debugDefaultTargetPlatformOverride = TargetPlatform.android;
      expect(DefaultFirebaseOptions.currentPlatform, equals(DefaultFirebaseOptions.android));
    });

    test('iOS platform returns iOS options', () {
      debugDefaultTargetPlatformOverride = TargetPlatform.iOS; 
      expect(DefaultFirebaseOptions.currentPlatform, equals(DefaultFirebaseOptions.ios));
    });

    test('macOS platform returns macOS options', () {
      debugDefaultTargetPlatformOverride = TargetPlatform.macOS;
      expect(DefaultFirebaseOptions.currentPlatform, equals(DefaultFirebaseOptions.macos));
    });

    test('windows platform returns windows options', () {
      debugDefaultTargetPlatformOverride = TargetPlatform.windows;
      expect(DefaultFirebaseOptions.currentPlatform, equals(DefaultFirebaseOptions.windows));
    });

    test('linux platform throws UnsupportedError', () {
      debugDefaultTargetPlatformOverride = TargetPlatform.linux;
      expect(() => DefaultFirebaseOptions.currentPlatform, 
        throwsA(isA<UnsupportedError>()));
    });

    tearDown(() {
      debugDefaultTargetPlatformOverride = null;
    });
  });
}