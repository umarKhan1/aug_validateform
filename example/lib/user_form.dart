import 'package:flutter/foundation.dart';
import 'package:aug_validateform/aug_validateform.dart';

part 'user_form.validate.dart';

@Validatable()
class UserForm with _$UserFormValidation {
  @Required(message: "Email is required")
  @Email()
  String email = "";

  @Required(message: "Phone is required")
  @Phone()
  String phone = "";

  @Required(message: "Password is required")
  @MinLength(8)
  @UpperCase()
  @Digit()
  @SpecialChar()
  String password = "";

  @Match('password', message: "Passwords do not match")
  String confirmPassword = "";
}
