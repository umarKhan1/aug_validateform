# aug_validateform

**High-Performance, Reactive Validation Engine for Flutter**

`aug_validateform` is a professional-grade validation suite designed to eliminate boilerplate by leveraging code generation and mixins. Define your validation rules directly on your data models using annotations, and let the generator handle the state management and logic for you.

---

## Author & Contact

Developed and maintained by **Muhammad Omar**.

- **LinkedIn**: [muhammad-omar-0335](https://www.linkedin.com/in/muhammad-omar-0335/)
- **GitHub**: [umarKhan1](https://github.com/umarKhan1)

If you find this package useful, consider giving it a star on [GitHub](https://github.com/umarKhan1/aug_validateform).

---

## Features

- **Boilerplate-Free**: Validation rules are defined via annotations, not repetitive UI code.
- **Reactive State**: Built-in `ValueNotifier` for real-time validation feedback.
- **Mixin Architecture**: Full IDE support with zero impact on class hierarchies.
- **Stackable Validators**: Combine multiple security and format rules on a single field.
- **Cross-Field Matching**: Easy implementation of password confirmation patterns.
- **Custom Error Messages**: Supports localized or custom error text for every rule.

---

## Getting Started

### 1. Installation

Add the following to your `pubspec.yaml`:

```yaml
dependencies:
  aug_validateform: latest_version

dev_dependencies:
  aug_validateform_generator: latest_version
  build_runner: ^1.0.0
```

### 2. Form Model Setup

Annotate your model with `@Validatable()` and apply the generated mixin.

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

### 3. Generate Logic

Run the code generator in your terminal:

```bash
dart run build_runner build --delete-conflicting-outputs
```

### 4. Integration with UI

Use the `ValidationWatcher` widget to display errors reactively for specific fields.

```dart
final form = RegistrationForm();

// Inside your build method:
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

// Triggering validation:
if (form.validate()) {
  // Proceed with registration
}
```

---

## Supported Annotations

| Annotation | Description | Customization |
| --- | --- | --- |
| `@Required` | Ensures field is not empty or null | `message` |
| `@Email` | Validates email address format | `message` |
| `@Phone` | Validates standard phone formats | `message` |
| `@Alphanumeric` | Digits and letters only | `message` |
| `@UpperCase` | At least one capital letter required | `message` |
| `@LowerCase` | At least one small letter required | `message` |
| `@Digit` | At least one number required | `message` |
| `@SpecialChar` | At least one symbol required | `message` |
| `@MinLength` | Minimum character constraint | `length`, `message` |
| `@MaxLength` | Maximum character constraint | `length`, `message` |
| `@Match` | Compares with another field | `fieldName`, `message` |
| `@CombinedPhoneEmail` | Accepts either Email or Phone | `message` |

---

## Advanced Documentation

### Stacking Validators
Apply multiple rules to a single field to build complex constraints:

```dart
@Required()
@MinLength(12)
@UpperCase()
@Digit()
@SpecialChar()
String securePassword = "";
```

### Logical OR Validation
Use `@CombinedPhoneEmail` when a field (like a login identifier) can be either a phone number or an email.

```dart
@CombinedPhoneEmail(message: "Enter a valid login identifier")
String identifier = "";
```

---

## License

This project is licensed under the MIT License.
