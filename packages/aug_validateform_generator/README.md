# aug_validateform_generator

Code generator for the `aug_validateform` package.

`aug_validateform_generator` provides the `build_runner` logic required to generate validation mixins for classes annotated with `@Validatable()`. It processes field-level annotations to produce robust, reactive validation logic.

## Purpose

This package is intended to be used as a `dev_dependency` alongside `aug_validateform`. It automatically generates the `.validate.dart` part files that contain the validation logic used by your models.

## Usage

For complete documentation on how to use the validation system, please refer to the primary [aug_validateform](https://pub.dev/packages/aug_validateform) package.

### Brief Setup

1. Add to `dev_dependencies`:
   ```yaml
   dev_dependencies:
     aug_validateform_generator: latest_version
     build_runner: ^2.4.0
   ```

2. Run the builder:
   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```

## Generated Logic

The generator creates a mixin named `_$ClassNameValidation` which includes:
- A reactive `ValueNotifier` for error state.
- A `errors` map getter for current validation messages.
- A `validate()` method that evaluates all field rules.

---

Copyright (c) 2026.
