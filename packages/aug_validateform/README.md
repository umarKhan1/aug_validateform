# aug_validateform 🚀

**Zero-Boilerplate, Reactive Validation for Flutter (2026 Standard)**

`aug_validateform` is a cutting-edge validation package that leverages **Dart Augmentation Libraries** to provide a seamless, boilerplate-free experience. No more manual `setState` calls or complex `Form` management. Just annotate your fields and go.

## Why Augmentations?

In 2026, Google paused general Macros to focus on **Augmentations** for stable, high-performance code generation. This package embraces this "modern way," ensuring your codebase remains clean and future-proof.

## Features

- ✅ **Zero Boilerplate**: Annotate and generate.
- ⚡ **Reactive State**: Built-in `ValueNotifier` for real-time UI updates.
- 🛠️ **Rich Annotation Suite**: Email, Phone, Security, Range, Cross-field matching, and more.
- 🧩 **Stackable**: Apply multiple validations to a single field.
- 🎯 **Localized Errors**: Custom messages support.

## Getting Started

### 1. Install

Add the dependencies to your `pubspec.yaml`:

```yaml
dependencies:
  aug_validateform: any

dev_dependencies:
  aug_validateform_generator: any
  build_runner: any
```

## Usage

### 1. Define your Form Model

Create a class, add the `@Validatable()` annotation to the class, and use the provided validation annotations on your fields.

```dart
import 'package:aug_validateform/aug_validateform.dart';
import 'package:flutter/foundation.dart'; // Required for ValueNotifier

// 1. Declare the generated part file
part 'user_form.validate.dart';

@Validatable()
// 2. Add the generated mixin
class UserForm with _$UserFormValidation {
  @Required(message: "Email is required")
  @Email()
  String email = "";

  @MinLength(8)
  @UpperCase()
  @Digit()
  String password = "";
}
```

### 2. Run the Generator

Run the following command in your terminal:

```bash
dart run build_runner build --delete-conflicting-outputs
```


### 4. Use in UI

Use `ValidationWatcher` to display errors without rebuilding the entire screen.

```dart
final myForm = UserForm();

// In your Column:
TextFormField(
  onChanged: (v) => myForm.email = v,
  decoration: InputDecoration(
    labelText: 'Email',
    errorText: myForm.errors['email'], // Basic usage
  ),
),

// Reactive usage (Better performance):
ValidationWatcher(
  notifier: myForm.validationNotifier,
  fieldName: 'email',
  builder: (context, error) => TextFormField(
    onChanged: (v) => myForm.email = v,
    decoration: InputDecoration(
       labelText: 'Email',
       errorText: error,
    ),
  ),
),

ElevatedButton(
  onPressed: () {
    if (myForm.validate()) {
      // Proceed!
    }
  },
  child: Text('Submit'),
)
```

## Documentation

### Available Annotations

| Annotation | Description |
| --- | --- |
| `@Required()` | Checks if field is null or empty string. |
| `@Email()` | Validates email format. |
| `@Phone()` | Validates phone number format. |
| `@Alphanumeric()` | Letters and numbers only. |
| `@UpperCase` / `@LowerCase` | Security checks for casing. |
| `@Digit` / `@SpecialChar` | Security checks for digits/symbols. |
| `@MinLength(int)` / `@MaxLength(int)` | Length constraints. |
| `@Match(String fieldName)` | Cross-field comparison. |
| `@CombinedPhoneEmail()` | Allows either Email or Phone. |

## Hosting & Publication 📦

If you plan to host this package on [pub.dev](https://pub.dev), follow these steps:

1. **Verify `pubspec.yaml`**: Ensure your version, description, and homepage are set.
2. **Add an Example**: Place a full working Flutter app in the `example/` folder (pub.dev uses this for the "Example" tab).
3. **Dartdoc**: Run `dart doc` to generate API documentation from your comments.
4. **License**: Include a `LICENSE` file in the root.
5. **Dry Run**:
   ```bash
   dart pub publish --dry-run
   ```

---

Built with ❤️ for the Flutter community in 2026.

