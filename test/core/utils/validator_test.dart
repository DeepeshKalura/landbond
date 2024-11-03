import 'package:flutter_test/flutter_test.dart';
import 'package:landbond/core/utils/validation.dart';

void main() {
  group('Validator', () {
    test('validateName returns error for null value', () {
      expect(Validator.validateName(null), 'Please enter your name');
    });

    test('validateName returns error for empty value', () {
      expect(Validator.validateName(''), 'Please enter your name');
    });

    test('validateName returns error for invalid name', () {
      expect(Validator.validateName('A'),
          'Name must be at least 2 characters and contain only letters and spaces');
      expect(Validator.validateName('123'),
          'Name must be at least 2 characters and contain only letters and spaces');
    });

    test('validateName returns null for valid name', () {
      expect(Validator.validateName('John Doe'), null);
    });

    test('validateEmail returns error for null value', () {
      expect(Validator.validateEmail(null), 'Please enter your email');
    });

    test('validateEmail returns error for empty value', () {
      expect(Validator.validateEmail(''), 'Please enter your email');
    });

    test('validateEmail returns null for valid email', () {
      expect(Validator.validateEmail('test@example.com'), null);
    });

    test('validatePassword returns error for null value', () {
      expect(Validator.validatePassword(null), 'Please enter your password');
    });

    test('validatePassword returns error for empty value', () {
      expect(Validator.validatePassword(''), 'Please enter your password');
    });

    test('validatePassword returns error for invalid password', () {
      expect(Validator.validatePassword('short'),
          'Password must be at least 8 characters, include a letter, a number, and a special character');
      expect(Validator.validatePassword('12345678'),
          'Password must be at least 8 characters, include a letter, a number, and a special character');
    });

    test('validatePassword returns null for valid password', () {
      expect(Validator.validatePassword('password1!'), null);
    });

    test('validateConfirmPassword returns error for null value', () {
      expect(Validator.validateConfirmPassword('password1', null),
          'Please confirm your password');
    });

    test('validateConfirmPassword returns error for empty value', () {
      expect(Validator.validateConfirmPassword('password1', ''),
          'Please confirm your password');
    });

    test('validateConfirmPassword returns error for non-matching passwords',
        () {
      expect(Validator.validateConfirmPassword('password1', 'password2'),
          'Passwords do not match');
    });

    test('validateConfirmPassword returns null for matching passwords', () {
      expect(Validator.validateConfirmPassword('password1', 'password1'), null);
    });
  });
}
