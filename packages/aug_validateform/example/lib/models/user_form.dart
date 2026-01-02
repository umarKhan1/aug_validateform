import 'package:aug_validateform/aug_validateform.dart';
import 'package:flutter/foundation.dart';

part 'user_form.validate.dart';

@Validatable()
class UserForm with _$UserFormValidation {
  @Required(message: "Day is required")
  String day = "";

  @Required(message: "Month is required")
  String month = "";

  @Required(message: "Year is required")
  String year = "";

  @Required(message: "Password is required")
  @MinLength(8, message: "Use at least 8 characters")
  @UpperCase(message: "Need 1 uppercase letter")
  @Digit(message: "Need 1 number")
  String password = "";

  @Required(message: "Phone number is required")
  @Phone(message: "Enter a valid phone number")
  String phoneNumber = "";

  @Required(message: "Security question is required")
  String securityQuestion = "";

  @Required(message: "Answer is required")
  String securityAnswer = "";
}
