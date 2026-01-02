import 'package:meta/meta_meta.dart';

/// Marks a class as validatable.
/// The generator will create validation logic for this class.
@Target({TargetKind.classType})
class Validatable {
  const Validatable();
}

/// Annotation to check if a field is null or empty.
@Target({TargetKind.field})
class Required {
  final String? message;
  const Required({this.message});
}

/// Annotation for Email validation (Regex-based).
@Target({TargetKind.field})
class Email {
  final String? message;
  const Email({this.message});
}

/// Annotation for Phone validation (Regex-based).
@Target({TargetKind.field})
class Phone {
  final String? message;
  const Phone({this.message});
}

/// Annotation for Alphanumeric validation (Letters and numbers only).
@Target({TargetKind.field})
class Alphanumeric {
  final String? message;
  const Alphanumeric({this.message});
}

/// Security Suite: Requires at least one upper case letter.
@Target({TargetKind.field})
class UpperCase {
  final String? message;
  const UpperCase({this.message});
}

/// Security Suite: Requires at least one lower case letter.
@Target({TargetKind.field})
class LowerCase {
  final String? message;
  const LowerCase({this.message});
}

/// Security Suite: Requires at least one digit.
@Target({TargetKind.field})
class Digit {
  final String? message;
  const Digit({this.message});
}

/// Security Suite: Requires at least one special character.
@Target({TargetKind.field})
class SpecialChar {
  final String? message;
  const SpecialChar({this.message});
}

/// Annotation for maximum length constraint.
@Target({TargetKind.field})
class MaxLength {
  final int length;
  final String? message;
  const MaxLength(this.length, {this.message});
}

/// Annotation for minimum length constraint.
@Target({TargetKind.field})
class MinLength {
  final int length;
  final String? message;
  const MinLength(this.length, {this.message});
}

/// Annotation for cross-field matching (e.g., password confirmation).
@Target({TargetKind.field})
class Match {
  final String fieldName;
  final String? message;
  const Match(this.fieldName, {this.message});
}

/// Combined: Allows either Email or Phone format.
@Target({TargetKind.field})
class CombinedPhoneEmail {
  final String? message;
  const CombinedPhoneEmail({this.message});
}
