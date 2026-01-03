import 'package:analyzer/dart/element/element.dart';
import 'package:aug_validateform_annotations/aug_validateform_annotations.dart';
import 'package:build/build.dart';
import 'package:path/path.dart' as p;
import 'package:source_gen/source_gen.dart';

/// Main entry point for the validation logic generator.
Builder augValidateFormBuilder(BuilderOptions options) => AugmentationBuilder();

/// A [Builder] that generates `.validate.dart` files containing validation mixins.
class AugmentationBuilder implements Builder {
  @override
  final buildExtensions = const {
    '.dart': ['.validate.dart']
  };

  @override
  Future<void> build(BuildStep buildStep) async {
    final resolver = buildStep.resolver;
    if (!await resolver.isLibrary(buildStep.inputId)) return;

    final library = await resolver.libraryFor(buildStep.inputId);
    final generator = ValidatableGenerator();
    final generatedCode =
        await generator.generate(LibraryReader(library), buildStep);

    if (generatedCode.trim().isEmpty) return;

    final outputId = buildStep.inputId.changeExtension('.validate.dart');

    final content = StringBuffer();
    content.writeln('part of \'${p.basename(buildStep.inputId.path)}\';');
    content.writeln();
    content.writeln('// ignore_for_file: type=lint');
    content.writeln();
    content.writeln(generatedCode);

    await buildStep.writeAsString(outputId, content.toString());
  }
}

/// [Generator] that finds classes annotated with [Validatable] and generates
/// validation logic for them.
class ValidatableGenerator extends Generator {
  /// Checker for the [Validatable] annotation.
  final TypeChecker validatableChecker = TypeChecker.typeNamed(Validatable);

  @override
  Future<String> generate(LibraryReader library, BuildStep buildStep) async {
    final buffer = StringBuffer();

    for (var annotatedElement in library.annotatedWith(validatableChecker)) {
      final element = annotatedElement.element;
      if (element is! ClassElement) continue;

      buffer.writeln(_generateClassAugmentation(element));
    }

    return buffer.toString();
  }

  String _generateClassAugmentation(ClassElement element) {
    final className = element.name;
    final buffer = StringBuffer();

    buffer.writeln('mixin _\$${className}Validation on Object {');
    buffer.writeln(
        '  final _validationNotifier = ValueNotifier<Map<String, String>>({});');
    buffer.writeln(
        '  ValueNotifier<Map<String, String>> get validationNotifier => _validationNotifier;');
    buffer.writeln(
        '  Map<String, String> get errors => _validationNotifier.value;');

    // Validate Method
    buffer.writeln('  bool validate() {');
    buffer.writeln('    final errors = <String, String>{};');

    for (var field in element.fields) {
      if (field.isSynthetic) continue;

      final fieldName = field.name;
      final checks = <String>[];

      void addCheck(Type annotationType, String condition, String defaultMsg) {
        final annot = _getAnnotation(field, annotationType);
        if (annot != null) {
          final msg = annot.peek('message')?.stringValue ?? defaultMsg;
          checks.add("if ($condition) { fieldErrors.add('$msg'); }");
        }
      }

      // Required
      addCheck(
          Required,
          "(this as dynamic).$fieldName == null || ((this as dynamic).$fieldName is String && ((this as dynamic).$fieldName as String).isEmpty)",
          "Field is required");

      // Email
      addCheck(
          Email,
          "(this as dynamic).$fieldName != null && !RegExp(r\"^[a-zA-Z0-9.a-zA-Z0-9.!#\$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\\.[a-zA-Z]+\").hasMatch((this as dynamic).$fieldName.toString())",
          "Invalid email address");

      // Phone
      addCheck(
          Phone,
          "(this as dynamic).$fieldName != null && !RegExp(r\"^\\+?[0-9]{7,15}\$\").hasMatch((this as dynamic).$fieldName.toString())",
          "Invalid phone number");

      // Alphanumeric
      addCheck(
          Alphanumeric,
          "(this as dynamic).$fieldName != null && !RegExp(r\"^[a-zA-Z0-9]+\$\").hasMatch((this as dynamic).$fieldName.toString())",
          "Only letters and numbers allowed");

      // Security Suite
      addCheck(
          UpperCase,
          "(this as dynamic).$fieldName != null && !RegExp(r'[A-Z]').hasMatch((this as dynamic).$fieldName.toString())",
          "Must contain an uppercase letter");
      addCheck(
          LowerCase,
          "(this as dynamic).$fieldName != null && !RegExp(r'[a-z]').hasMatch((this as dynamic).$fieldName.toString())",
          "Must contain a lowercase letter");
      addCheck(
          Digit,
          "(this as dynamic).$fieldName != null && !RegExp(r'[0-9]').hasMatch((this as dynamic).$fieldName.toString())",
          "Must contain a digit");
      addCheck(
          SpecialChar,
          "(this as dynamic).$fieldName != null && !RegExp(r'[!@#\\\$%^&*(),.?\":{}|<>]').hasMatch((this as dynamic).$fieldName.toString())",
          "Must contain a special character");

      // Range
      final minLen = _getAnnotation(field, MinLength);
      if (minLen != null) {
        final len = minLen.peek('length')?.intValue ?? 0;
        final msg =
            minLen.peek('message')?.stringValue ?? "Minimum length is $len";
        checks.add(
            "if ((this as dynamic).$fieldName != null && (this as dynamic).$fieldName.toString().length < $len) { fieldErrors.add('$msg'); }");
      }

      final maxLen = _getAnnotation(field, MaxLength);
      if (maxLen != null) {
        final len = maxLen.peek('length')?.intValue ?? 0;
        final msg =
            maxLen.peek('message')?.stringValue ?? "Maximum length is $len";
        checks.add(
            "if ((this as dynamic).$fieldName != null && (this as dynamic).$fieldName.toString().length > $len) { fieldErrors.add('$msg'); }");
      }

      // Match
      final matchAnnot = _getAnnotation(field, Match);
      if (matchAnnot != null) {
        final otherField = matchAnnot.peek('fieldName')?.stringValue;
        if (otherField != null) {
          final msg = matchAnnot.peek('message')?.stringValue ??
              "Does not match $otherField";
          checks.add(
              "if ((this as dynamic).$fieldName != (this as dynamic).$otherField) { fieldErrors.add('$msg'); }");
        }
      }

      // Combined
      final combinedAnnot = _getAnnotation(field, CombinedPhoneEmail);
      if (combinedAnnot != null) {
        final msg = combinedAnnot.peek('message')?.stringValue ??
            "Must be a valid email or phone number";
        checks.add("""
          final isEmail_ = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#\\\$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\\\\.[a-zA-Z]+").hasMatch((this as dynamic).$fieldName.toString());
          final isPhone_ = RegExp(r"^\\\\+?[0-9]{7,15}\\\$").hasMatch((this as dynamic).$fieldName.toString());
          if ((this as dynamic).$fieldName != null && !isEmail_ && !isPhone_) { fieldErrors.add('$msg'); }
        """);
      }

      if (checks.isNotEmpty) {
        buffer.writeln('    {');
        buffer.writeln('      final fieldErrors = <String>[];');
        for (var check in checks) {
          buffer.writeln('      $check');
        }
        buffer.writeln('      if (fieldErrors.isNotEmpty) {');
        buffer.writeln("        errors['$fieldName'] = fieldErrors.first;");
        buffer.writeln('      }');
        buffer.writeln('    }');
      }
    }

    buffer.writeln('    _validationNotifier.value = errors;');
    buffer.writeln('    return errors.isEmpty;');
    buffer.writeln('  }');
    buffer.writeln('}');

    return buffer.toString();
  }

  ConstantReader? _getAnnotation(FieldElement field, Type annotationType) {
    final annot =
        TypeChecker.typeNamed(annotationType).firstAnnotationOfExact(field);
    return annot != null ? ConstantReader(annot) : null;
  }
}
