import 'package:flutter/widgets.dart';

/// A widget that watches for validation errors on a specific field.
class ValidationWatcher extends StatelessWidget {
  /// The validation notifier from the [Validatable] class.
  final ValueNotifier<Map<String, String>> notifier;

  /// The field name to watch.
  final String fieldName;

  /// A builder that provides the error message (if any) to its child.
  final Widget Function(BuildContext context, String? error) builder;

  const ValidationWatcher({
    super.key,
    required this.notifier,
    required this.fieldName,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Map<String, String>>(
      valueListenable: notifier,
      builder: (context, errors, _) {
        return builder(context, errors[fieldName]);
      },
    );
  }
}
