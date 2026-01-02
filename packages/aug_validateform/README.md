# aug_validateform

Professional, Reactive Validation for Flutter applications.

`aug_validateform` provides a streamlined validation experience by leveraging code generation and mixins to inject validation logic directly into your form models. This approach eliminates the need for manual state management and repetitive validation boilerplate in your UI.

## Features

- **Boilerplate Reduction**: Definition of validation rules via annotations directly on model fields.
- **Reactive State Management**: Integrated `ValueNotifier` provides real-time validation feedback to the UI.
- **Extensive Validation Suite**: Comprehensive set of validators including format checks, security constraints, and cross-field matching.
- **Mixin-based Architecture**: Ensures full IDE support and static analysis without complex class hierarchies.
- **Customizable Error Messages**: Support for localized or custom error text for every validation rule.

## Getting Started

### Installation

Add the following dependencies to your `pubspec.yaml` file:

```yaml
dependencies:
  aug_validateform: latest_version

dev_dependencies:
  aug_validateform_generator: latest_version
  build_runner: ^2.4.0
```

## Usage

### 1. Define the Form Model

Annotate your model class with `@Validatable()` and apply the validation mixin. Define your validation rules using the provided annotations.

```dart
import 'package:aug_validateform/aug_validateform.dart';
import 'package:flutter/foundation.dart';

part 'registration_form.validate.dart';

@Validatable()
class RegistrationForm with _$RegistrationFormValidation {
  @Required(message: "Email is required")
  @Email()
  String email = "";

  @Required()
  @MinLength(8)
  @UpperCase()
  @Digit()
  String password = "";

  @Match('password', message: "Passwords do not match")
  String confirmPassword = "";
}
```

### 2. Generate Validation Logic

Execute the following command to generate the validation mixin:

```bash
dart run build_runner build --delete-conflicting-outputs
```

### 3. Integrate with UI

Utilize the generated `validationNotifier` and the `ValidationWatcher` widget to display errors reactively.

```dart
final form = RegistrationForm();

// Reactive error display using ValidationWatcher
ValidationWatcher(
  notifier: form.validationNotifier,
  fieldName: 'email',
  builder: (context, error) => TextFormField(
    onChanged: (value) => form.email = value,
    decoration: InputDecoration(
      labelText: 'Email Address',
      errorText: error,
    ),
  ),
);

// Triggering validation
ElevatedButton(
  onPressed: () {
    if (form.validate()) {
      // Validated successfully
    }
  },
  child: const Text('Register'),
);
```

## Supported Annotations

| Annotation | Description |
| --- | --- |
| `@Required({String? message})` | Ensures the field is not null or an empty string. |
| `@Email({String? message})` | Validates that the input is a correctly formatted email address. |
| `@Phone({String? message})` | Validates standard phone number formats. |
| `@Alphanumeric({String? message})` | Restricts input to letters and numbers only. |
| `@UpperCase({String? message})` | Requires at least one uppercase letter. |
| `@LowerCase({String? message})` | Requires at least one lowercase letter. |
| `@Digit({String? message})` | Requires at least one numerical digit. |
| `@SpecialChar({String? message})` | Requires at least one special character. |
| `@MinLength(int length, {String? message})` | Enforces a minimum character count. |
| `@MaxLength(int length, {String? message})` | Enforces a maximum character count. |
| `@Match(String fieldName, {String? message})` | Ensures the field value matches another specified field. |
| `@CombinedPhoneEmail({String? message})` | Accepts either a valid email address or a phone number. |

## Advanced Logic

Most validators are stackable, allowing you to build complex security rules on a single field by applying multiple annotations.

```dart
@Required()
@MinLength(12)
@UpperCase()
@Digit()
@SpecialChar()
String complexPassword = "";
```

## Publication Checklist

For consistent quality on pub.dev:
1. Ensure `pubspec.yaml` has a valid description and homepage.
2. Verify the `example/` folder contains a complete working application.
3. Adhere to Dart linting standards by running `dart analyze`.

---

Copyright (c) 2026.
