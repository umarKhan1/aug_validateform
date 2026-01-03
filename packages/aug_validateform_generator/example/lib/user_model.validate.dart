part of 'user_model.dart';

// ignore_for_file: type=lint

mixin _$UserModelValidation on Object {
  final _validationNotifier = ValueNotifier<Map<String, String>>({});
  ValueNotifier<Map<String, String>> get validationNotifier => _validationNotifier;
  Map<String, String> get errors => _validationNotifier.value;
  bool validate() {
    final errors = <String, String>{};
    {
      final fieldErrors = <String>[];
      if ((this as dynamic).email == null || ((this as dynamic).email is String && ((this as dynamic).email as String).isEmpty)) { fieldErrors.add('Field is required'); }
      if ((this as dynamic).email != null && !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch((this as dynamic).email.toString())) { fieldErrors.add('Invalid email address'); }
      if (fieldErrors.isNotEmpty) {
        errors['email'] = fieldErrors.first;
      }
    }
    {
      final fieldErrors = <String>[];
      if ((this as dynamic).password != null && (this as dynamic).password.toString().length < 8) { fieldErrors.add('Minimum length is 8'); }
      if (fieldErrors.isNotEmpty) {
        errors['password'] = fieldErrors.first;
      }
    }
    _validationNotifier.value = errors;
    return errors.isEmpty;
  }
}


