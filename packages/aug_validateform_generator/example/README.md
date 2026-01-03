# aug_validateform_generator Example

This example demonstrates how to use `aug_validateform_generator` to generate validation logic for your data models.

## Setup

1. Add the dependencies to your `pubspec.yaml`:

```yaml
dependencies:
  aug_validateform_annotations: ^0.0.1-dev.1

dev_dependencies:
  aug_validateform_generator: ^0.0.1-dev.1
  build_runner: ^2.4.8
```

2. Run the generator:

```bash
dart run build_runner build
```

## Example Model

```dart
import 'package:aug_validateform_annotations/aug_validateform_annotations.dart';

part 'user_model.validate.dart';

@Validatable()
class UserModel with _$UserModelValidation {
  @Required()
  @Email()
  String email = "";

  @MinLength(8)
  String password = "";
}
```
