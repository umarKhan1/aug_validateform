import 'package:flutter/material.dart';

class CustomInputField extends StatelessWidget {
  final String label;
  final String? errorText;
  final ValueChanged<String> onChanged;
  final bool isPassword;
  final Widget? prefix;
  final Widget? suffix;
  final String? placeholder;

  const CustomInputField({
    super.key,
    required this.label,
    required this.onChanged,
    this.errorText,
    this.isPassword = false,
    this.prefix,
    this.suffix,
    this.placeholder,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label.isNotEmpty) ...[
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
        ],
        Container(
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: errorText != null ? Colors.red : Colors.grey[200]!,
            ),
          ),
          child: TextField(
            onChanged: onChanged,
            obscureText: isPassword,
            decoration: InputDecoration(
              hintText: placeholder,
              prefixIcon: prefix,
              suffixIcon: suffix,
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 16,
              ),
            ),
          ),
        ),
        if (errorText != null)
          Padding(
            padding: const EdgeInsets.only(top: 8, left: 12),
            child: Text(
              errorText!,
              style: const TextStyle(color: Colors.red, fontSize: 12),
            ),
          ),
      ],
    );
  }
}
