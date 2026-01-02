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
  /// The error message to display when validation fails.
  final String? message;

  /// Creates a [Required] annotation.
  const Required({this.message});
}

/// Annotation for Email validation (Regex-based).
@Target({TargetKind.field})
class Email {
  /// The error message to display when validation fails.
  final String? message;

  /// Creates an [Email] annotation.
  const Email({this.message});
}

/// Annotation for Phone validation (Regex-based).
@Target({TargetKind.field})
class Phone {
  /// The error message to display when validation fails.
  final String? message;

  /// Creates a [Phone] annotation.
  const Phone({this.message});
}

/// Annotation for Alphanumeric validation (Letters and numbers only).
@Target({TargetKind.field})
class Alphanumeric {
  /// The error message to display when validation fails.
  final String? message;

  /// Creates an [Alphanumeric] annotation.
  const Alphanumeric({this.message});
}

/// Security Suite: Requires at least one upper case letter.
@Target({TargetKind.field})
class UpperCase {
  /// The error message to display when validation fails.
  final String? message;

  /// Creates an [UpperCase] annotation.
  const UpperCase({this.message});
}

/// Security Suite: Requires at least one lower case letter.
@Target({TargetKind.field})
class LowerCase {
  /// The error message to display when validation fails.
  final String? message;

  /// Creates a [LowerCase] annotation.
  const LowerCase({this.message});
}

/// Security Suite: Requires at least one digit.
@Target({TargetKind.field})
class Digit {
  /// The error message to display when validation fails.
  final String? message;

  /// Creates a [Digit] annotation.
  const Digit({this.message});
}

/// Security Suite: Requires at least one special character.
@Target({TargetKind.field})
class SpecialChar {
  /// The error message to display when validation fails.
  final String? message;

  /// Creates a [SpecialChar] annotation.
  const SpecialChar({this.message});
}

/// Annotation for maximum length constraint.
@Target({TargetKind.field})
class MaxLength {
  /// The maximum length allowed.
  final int length;

  /// The error message to display when validation fails.
  final String? message;

  /// Creates a [MaxLength] annotation.
  const MaxLength(this.length, {this.message});
}

/// Annotation for minimum length constraint.
@Target({TargetKind.field})
class MinLength {
  /// The minimum length required.
  final int length;

  /// The error message to display when validation fails.
  final String? message;

  /// Creates a [MinLength] annotation.
  const MinLength(this.length, {this.message});
}

/// Annotation for cross-field matching (e.g., password confirmation).
@Target({TargetKind.field})
class Match {
  /// The name of the field to match against.
  final String fieldName;

  /// The error message to display when validation fails.
  final String? message;

  /// Creates a [Match] annotation.
  const Match(this.fieldName, {this.message});
}

/// Combined: Allows either Email or Phone format.
@Target({TargetKind.field})
class CombinedPhoneEmail {
  /// The error message to display when validation fails.
  final String? message;

  /// Creates a [CombinedPhoneEmail] annotation.
  const CombinedPhoneEmail({this.message});
}
