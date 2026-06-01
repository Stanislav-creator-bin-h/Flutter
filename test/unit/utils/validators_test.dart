import 'package:flutter_test/flutter_test.dart';
import 'package:lr14_testing/utils/validators.dart';

void main() {
  group('Validators (Unit)', () {
    test('validateTitle returns null for valid text', () {
      expect(Validators.validateTitle('Good title'), isNull);
    });

    test('validateTitle returns error for empty text', () {
      expect(Validators.validateTitle(''), 'Title cannot be empty');
    });

    test('validateTitle returns error for null', () {
      expect(Validators.validateTitle(null), 'Title cannot be empty');
    });
    
    test('validateTitle returns error for spaces only', () {
      expect(Validators.validateTitle('   '), 'Title cannot be empty');
    });
  });
}