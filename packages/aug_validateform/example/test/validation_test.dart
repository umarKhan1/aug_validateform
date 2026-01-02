import 'package:flutter_test/flutter_test.dart';
import 'package:example/models/user_form.dart';

void main() {
  group('UserForm Validation', () {
    late UserForm form;

    setUp(() {
      form = UserForm();
    });

    test('Initial form should be invalid (empty fields)', () {
      final isValid = form.validate();
      expect(isValid, isFalse);
      expect(form.errors['day'], isNotNull);
      expect(form.errors['password'], isNotNull);
      expect(form.errors['phoneNumber'], isNotNull);
    });

    test('Valid form should pass', () {
      form.day = "1";
      form.month = "Jan";
      form.year = "2026";
      form.password = "StrongPass1";
      form.phoneNumber = "1234567890";
      form.securityQuestion = "What is your pet's name?";
      form.securityAnswer = "Fluffy";

      final isValid = form.validate();
      expect(isValid, isTrue);
      expect(form.errors, isEmpty);
    });

    test('Phone format validation should work', () {
      form.phoneNumber = "abc";
      form.validate();
      expect(form.errors['phoneNumber'], equals("Enter a valid phone number"));
    });

    test('Security validation should work', () {
      form.password = "123";
      form.validate();
      expect(form.errors['password'], isNotNull);
      // UpperCase check is before MinLength in current implementation logic
      expect(form.errors['password'], contains("uppercase"));
    });

    test('Empty fields should report required errors', () {
      form.day = "";
      form.validate();
      expect(form.errors['day'], equals("Day is required"));
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
