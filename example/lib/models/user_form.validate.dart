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
      if ((this as dynamic).day == null || ((this as dynamic).day is String && ((this as dynamic).day as String).isEmpty)) { fieldErrors.add('Day is required'); }
      if (fieldErrors.isNotEmpty) {
        errors['day'] = fieldErrors.first;
      }
    }
    {
      final fieldErrors = <String>[];
      if ((this as dynamic).month == null || ((this as dynamic).month is String && ((this as dynamic).month as String).isEmpty)) { fieldErrors.add('Month is required'); }
      if (fieldErrors.isNotEmpty) {
        errors['month'] = fieldErrors.first;
      }
    }
    {
      final fieldErrors = <String>[];
      if ((this as dynamic).year == null || ((this as dynamic).year is String && ((this as dynamic).year as String).isEmpty)) { fieldErrors.add('Year is required'); }
      if (fieldErrors.isNotEmpty) {
        errors['year'] = fieldErrors.first;
      }
    }
    {
      final fieldErrors = <String>[];
      if ((this as dynamic).password == null || ((this as dynamic).password is String && ((this as dynamic).password as String).isEmpty)) { fieldErrors.add('Password is required'); }
      if ((this as dynamic).password != null && !RegExp(r'[A-Z]').hasMatch((this as dynamic).password.toString())) { fieldErrors.add('Need 1 uppercase letter'); }
      if ((this as dynamic).password != null && !RegExp(r'[0-9]').hasMatch((this as dynamic).password.toString())) { fieldErrors.add('Need 1 number'); }
      if ((this as dynamic).password != null && (this as dynamic).password.toString().length < 8) { fieldErrors.add('Use at least 8 characters'); }
      if (fieldErrors.isNotEmpty) {
        errors['password'] = fieldErrors.first;
      }
    }
    {
      final fieldErrors = <String>[];
      if ((this as dynamic).phoneNumber == null || ((this as dynamic).phoneNumber is String && ((this as dynamic).phoneNumber as String).isEmpty)) { fieldErrors.add('Phone number is required'); }
      if ((this as dynamic).phoneNumber != null && !RegExp(r"^\+?[0-9]{7,15}$").hasMatch((this as dynamic).phoneNumber.toString())) { fieldErrors.add('Enter a valid phone number'); }
      if (fieldErrors.isNotEmpty) {
        errors['phoneNumber'] = fieldErrors.first;
      }
    }
    {
      final fieldErrors = <String>[];
      if ((this as dynamic).securityQuestion == null || ((this as dynamic).securityQuestion is String && ((this as dynamic).securityQuestion as String).isEmpty)) { fieldErrors.add('Security question is required'); }
      if (fieldErrors.isNotEmpty) {
        errors['securityQuestion'] = fieldErrors.first;
      }
    }
    {
      final fieldErrors = <String>[];
      if ((this as dynamic).securityAnswer == null || ((this as dynamic).securityAnswer is String && ((this as dynamic).securityAnswer as String).isEmpty)) { fieldErrors.add('Answer is required'); }
      if (fieldErrors.isNotEmpty) {
        errors['securityAnswer'] = fieldErrors.first;
      }
    }
    _validationNotifier.value = errors;
    return errors.isEmpty;
  }
}


