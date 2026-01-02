# aug_validateform

[![Pub Version](https://img.shields.io/pub/v/aug_validateform)](https://pub.dev/packages/aug_validateform)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)
[![Build Status](https://img.shields.io/github/actions/workflow/status/umarKhan1/aug_validateform/ci.yml?branch=main)](https://github.com/umarKhan1/aug_validateform/actions)

`aug_validateform` is a zero-boilerplate, type-safe validation engine that weaves logic directly into your models using the stable Augmentation pattern. Unlike traditional form builders, it preserves your pure data models while providing reactive `ValueNotifier` feedback with zero reflective overhead.

---

## The Problem & The Solution

In modern Flutter development, complex forms often lead to a "Maintenance Nightmare." `aug_validateform` solves this by moving logic out of the UI and into a generated, high-performance validation layer.

| Feature | The Legacy Reality | The `aug_validateform` Way |
| :--- | :--- | :--- |
| **Type Safety** | String-keyed maps or dynamic fields | Fully type-safe model signatures |
| **State Management** | Manual `setState` or controller hacks | Auto-generated `ValueNotifier` state |
| **Boilerplate** | 50+ lines of validator logic in UI | High-density field annotations |
| **Performance** | Runtime reflection or heavy wrappers | Native Augmentation injection (Wasm-Ready) |

---
## Architectural Transparency

How does it work? Unlike legacy generators that rely on messy mixins or slow reflection, `aug_validateform` uses the Dart Augmentation Library standard.

When you run `build_runner`, the engine doesn't just create a separate file; it "augments" your existing class. By using the `augment class` keyword, I inject the `validationNotifier` and `validate()` methods directly into your model. This approach is 100% Wasm-compatible and preserves a clean class hierarchy—no `with _$Mixin` required.

---
### Reactive Validation in Action
![Reactive Validation Demo](https://raw.githubusercontent.com/umarKhan1/aug_validateform/main/packages/aug_validateform/examplegif.gif)

---

## Quick Start

### Step 1: `pubspec.yaml` Setup
Add the core and the generator to your project:

```yaml
dependencies:
  aug_validateform: latest_version

dev_dependencies:
  aug_validateform_generator: latest_version
  build_runner: ^2.4.0
```

### Step 2: Define Your Validation Model
Annotate your class and let the engine augment it with validation powers.

```dart
import 'package:aug_validateform/aug_validateform.dart';
import 'package:flutter/foundation.dart';

import 'user_form.validate.dart'; // Source generation handles the rest

@Validatable()
class UserForm {
  @Required(message: "Email is required")
  @Email()
  String email = "";

  @Required()
  @MinLength(8)
  @UpperCase()
  @Digit()
  @SpecialChar()
  String password = "";

  @Match('password', message: "Passwords do not match")
  String confirmPassword = "";
}
```

### Step 3: Run the Engine
Generate the performance-optimized code:

```bash
dart run build_runner build --delete-conflicting-outputs
```

### Step 4: Reactive UI Integration
Observe errors with surgically precise rebuilds using `ValidationWatcher`.

```dart
ValidationWatcher(
  notifier: form.validationNotifier,
  fieldName: 'email',
  builder: (context, error) => TextFormField(
    onChanged: (v) => form.email = v,
    decoration: InputDecoration(
      labelText: 'Email Address',
      errorText: error,
    ),
  ),
);
```

---

## Validator Reference

The validator suite is built for modern security and format requirements.

| Annotation | Description | Parameters |
| :--- | :--- | :--- |
| `@Required` | Checks for null or empty strings | `message` |
| `@Email` | Validates standard email formats | `message` |
| `@Phone` | Validates international phone formats | `message` |
| `@Alphanumeric`| Letters and numbers only | `message` |
| `@UpperCase` | Requires at least one capital letter | `message` |
| `@LowerCase` | Requires at least one small letter | `message` |
| `@Digit` | Requires at least one numerical digit | `message` |
| `@SpecialChar` | Requires at least one symbol | `message` |
| `@MinLength` | Enforces minimum string length | `length`, `message` |
| `@MaxLength` | Enforces maximum string length | `length`, `message` |
| `@Match` | Cross-field comparison logic | `fieldName`, `message` |
| `@Combined...` | Logical OR (Email or Phone) | `message` |

---

## Community & Contributing

I welcome contributions! If you find a bug or have a feature request, please open an issue on the [GitHub repository](https://github.com/umarKhan1/aug_validateform).

### Meet the Author

Developed and maintained by **Muhammad Omar**.
- **LinkedIn**: [muhammad-omar-0335](https://www.linkedin.com/in/muhammad-omar-0335/)
- **GitHub**: [umarKhan1](https://github.com/umarKhan1)

---

## License

This project is licensed under the MIT License - see the `LICENSE` file for details.
