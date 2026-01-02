import 'package:flutter_test/flutter_test.dart';
import 'package:example/user_form.dart';

void main() {
  group('UserForm Validation', () {
    late UserForm form;

    setUp(() {
      form = UserForm();
    });

    test('Initial form should be invalid (empty fields)', () {
      final isValid = form.validate();
      expect(isValid, isFalse);
      expect(form.errors['email'], isNotNull);
      expect(form.errors['password'], isNotNull);
    });

    test('Valid form should pass', () {
      form.email = "test@example.com";
      form.phone = "1234567890";
      form.password = "StrongPass123!";
      form.confirmPassword = "StrongPass123!";

      final isValid = form.validate();
      expect(isValid, isTrue);
      expect(form.errors, isEmpty);
    });

    test('Email format validation should work', () {
      form.email = "invalid-email";
      form.validate();
      expect(form.errors['email'], equals("Invalid email address"));
    });

    test('Security validation should work', () {
      form.password = "123";
      form.validate();
      expect(form.errors['password'], isNotNull);
      // UpperCase check is before MinLength
      expect(form.errors['password'], contains("uppercase"));
    });

    test('Password match validation should work', () {
      form.password = "StrongPass123!";
      form.confirmPassword = "DifferentPass123!";
      form.validate();
      expect(form.errors['confirmPassword'], equals("Passwords do not match"));
    });

    test('ValueNotifier should update on validate', () {
      bool notified = false;
      form.validationNotifier.addListener(() {
        notified = true;
      });

      form.validate();
      expect(notified, isTrue);
    });
  });
}
