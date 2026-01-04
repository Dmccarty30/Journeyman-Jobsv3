import 'dart:io';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Architecture Directory Structure Tests', () {
    final features = [
      'jobs',
      'storm',
      'unions',
      'profile',
      'auth',
      'onboarding',
      'navigation',
      'crews',
    ];

    final subDirs = [
      'models',
      'providers',
      'screens',
      'services',
      'widgets',
    ];

    for (final feature in features) {
      test('Feature $feature has required subdirectories', () {
        final featurePath = 'lib/features/$feature';
        expect(Directory(featurePath).existsSync(), isTrue, reason: 'Feature directory $featurePath should exist');
        
        for (final subDir in subDirs) {
          final subDirPath = '$featurePath/$subDir';
          expect(Directory(subDirPath).existsSync(), isTrue, reason: 'Subdirectory $subDirPath should exist');
        }
      });
    }
  });
}
