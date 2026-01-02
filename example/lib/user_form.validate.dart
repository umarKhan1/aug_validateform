part of 'user_form.dart';

// ignore_for_file: type=lint

mixin _$UserFormValidation on Object {
  final _validationNotifier = ValueNotifier<Map<String, String>>({});
  ValueNotifier<Map<String, String>> get validationNotifier => _validationNotifier;
  Map<String, String> get errors => _validationNotifier.value;
  bool validate() {
    final errors = <String, String>{};
    {
      final fieldErrors = <String>[];
      if ((this as dynamic).email == null || ((this as dynamic).email is String && ((this as dynamic).email as String).isEmpty)) { fieldErrors.add('Email is required'); }
      if ((this as dynamic).email != null && !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch((this as dynamic).email.toString())) { fieldErrors.add('Invalid email address'); }
      if (fieldErrors.isNotEmpty) {
        errors['email'] = fieldErrors.first;
      }
    }
    {
      final fieldErrors = <String>[];
      if ((this as dynamic).phone == null || ((this as dynamic).phone is String && ((this as dynamic).phone as String).isEmpty)) { fieldErrors.add('Phone is required'); }
      if ((this as dynamic).phone != null && !RegExp(r"^\+?[0-9]{7,15}$").hasMatch((this as dynamic).phone.toString())) { fieldErrors.add('Invalid phone number'); }
      if (fieldErrors.isNotEmpty) {
        errors['phone'] = fieldErrors.first;
      }
    }
    {
      final fieldErrors = <String>[];
      if ((this as dynamic).password == null || ((this as dynamic).password is String && ((this as dynamic).password as String).isEmpty)) { fieldErrors.add('Password is required'); }
      if ((this as dynamic).password != null && !RegExp(r'[A-Z]').hasMatch((this as dynamic).password.toString())) { fieldErrors.add('Must contain an uppercase letter'); }
      if ((this as dynamic).password != null && !RegExp(r'[0-9]').hasMatch((this as dynamic).password.toString())) { fieldErrors.add('Must contain a digit'); }
      if ((this as dynamic).password != null && !RegExp(r'[!@#\$%^&*(),.?":{}|<>]').hasMatch((this as dynamic).password.toString())) { fieldErrors.add('Must contain a special character'); }
      if ((this as dynamic).password != null && (this as dynamic).password.toString().length < 8) { fieldErrors.add('Minimum length is 8'); }
      if (fieldErrors.isNotEmpty) {
        errors['password'] = fieldErrors.first;
      }
    }
    {
      final fieldErrors = <String>[];
      if ((this as dynamic).confirmPassword != (this as dynamic).password) { fieldErrors.add('Passwords do not match'); }
      if (fieldErrors.isNotEmpty) {
        errors['confirmPassword'] = fieldErrors.first;
      }
    }
    _validationNotifier.value = errors;
    return errors.isEmpty;
  }
}


