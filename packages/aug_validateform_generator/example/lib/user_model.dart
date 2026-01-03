import 'package:aug_validateform_annotations/aug_validateform_annotations.dart';

part 'user_model.validate.dart';

// Mock ValueNotifier for pure Dart example analysis
class ValueNotifier<T> {
  ValueNotifier(this.value);
  T value;
}

@Validatable()
class UserModel with _$UserModelValidation {
  @Required()
  @Email()
  String email = "";

  @MinLength(8)
  String password = "";
}
