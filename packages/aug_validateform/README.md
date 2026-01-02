# aug_validateform

A modern, high-performance validation engine for Flutter that eliminates boilerplate through code generation and reactive state management.

`aug_validateform` is designed for developers who value clean architecture and developer productivity. By defining validation rules directly on your data models using annotations, the package automatically generates the underlying logic and state management required to power your forms.

---

## Key Features

- **Boilerplate-Free**: Validation logic is injected directly into your models via generated mixins.
- **Reactive by Design**: Built-in `ValueNotifier` ensures your UI updates instantly as data changes.
- **High-Performance**: Minimal overhead, leveraging Dart's native mixin capabilities for static analysis and speed.
- **Developer-Centric**: Full IDE support, including autocomplete for generated members.
- **Comprehensive Suite**: From simple required fields to complex cross-field password matching.

---

## Installation

Add the following to your `pubspec.yaml`:

```yaml
dependencies:
  aug_validateform: latest_version

dev_dependencies:
  aug_validateform_generator: latest_version
  build_runner: ^1.0.0
```

---

## Implementation Guide

### 1. Define Your Form Model

Annotate your class with `@Validatable()` and include the generated part file. Apply the generated mixin to your class.

```dart
import 'package:aug_validateform/aug_validateform.dart';
import 'package:flutter/foundation.dart';

part 'user_form.validate.dart';

@Validatable()
class UserForm with _$UserFormValidation {
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

### 2. Generate the Validation Logic

Run the following command in your terminal to process the annotations:

```bash
dart run build_runner build --delete-conflicting-outputs
```

### 3. Connect to the UI

Use the `ValidationWatcher` widget to observe error states on a per-field basis, preventing unnecessary global rebuilds.

```dart
final form = UserForm();

// In your Widget tree:
ValidationWatcher(
  notifier: form.validationNotifier,
  fieldName: 'email',
  builder: (context, error) => TextFormField(
    onChanged: (value) => form.email = value,
    decoration: InputDecoration(
      labelText: 'Email',
      errorText: error,
    ),
  ),
);

// To trigger validation (e.g., on Submit):
bool isValid = form.validate();
```

---

## Validator Reference

| Annotation | Purpose | Customization |
| --- | --- | --- |
| `@Required` | Checks for null or empty strings | `message` |
| `@Email` | Validates standard email formats | `message` |
| `@Phone` | Validates international phone formats | `message` |
| `@Alphanumeric` | Ensures only letters and numbers | `message` |
| `@UpperCase` | Requires at least one capital letter | `message` |
| `@LowerCase` | Requires at least one small letter | `message` |
| `@Digit` | Requires at least one numeric character | `message` |
| `@SpecialChar` | Requires at least one symbol | `message` |
| `@MinLength` | Enforces a minimum character count | `length`, `message` |
| `@MaxLength` | Enforces a maximum character count | `length`, `message` |
| `@Match` | Compares value with another field | `fieldName`, `message` |
| `@CombinedPhoneEmail` | Logic OR between Email and Phone | `message` |

---

## Advanced Usage

### Stacking Validators
Validators can be stacked on a single field. They are evaluated in the order they are declared.

```dart
@Required()
@MinLength(12)
@UpperCase()
@Digit()
@SpecialChar()
String complexPassword = "";
```

### Logical Gateways
Use `@CombinedPhoneEmail` when a field can accept multiple formats.

```dart
@CombinedPhoneEmail(message: "Please enter a valid email or phone number")
String username = "";
```

---

## Connect with the Author

Developed and maintained by **Muhammad Omar**.

- **LinkedIn**: [muhammad-omar-0335](https://www.linkedin.com/in/muhammad-omar-0335/)
- **GitHub**: [umarKhan1](https://github.com/umarKhan1)

If you find this package useful, consider giving it a star on [GitHub](https://github.com/umarKhan1/aug_validateform).

---

## License

This project is licensed under the MIT License.
