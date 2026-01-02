import 'package:flutter/material.dart';
import 'package:aug_validateform/aug_validateform.dart';
import 'user_form.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'aug_validateform Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: const RegistrationScreen(),
    );
  }
}

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _form = UserForm();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('2026 Registration Form')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const Text(
              'Zero-Boilerplate Validation',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text('Built with Dart Augmentations'),
            const SizedBox(height: 32),

            _buildField(
              label: 'Email Address',
              fieldName: 'email',
              onChanged: (v) => _form.email = v,
              icon: Icons.email_outlined,
            ),
            const SizedBox(height: 16),

            _buildField(
              label: 'Phone Number',
              fieldName: 'phone',
              onChanged: (v) => _form.phone = v,
              icon: Icons.phone_outlined,
            ),
            const SizedBox(height: 16),

            _buildField(
              label: 'Password',
              fieldName: 'password',
              onChanged: (v) => _form.password = v,
              obscure: true,
              icon: Icons.lock_outline,
            ),
            const SizedBox(height: 16),

            _buildField(
              label: 'Confirm Password',
              fieldName: 'confirmPassword',
              onChanged: (v) => _form.confirmPassword = v,
              obscure: true,
              icon: Icons.lock_reset,
            ),

            const SizedBox(height: 32),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  if (_form.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Validation Passed! 🚀')),
                    );
                  }
                },
                child: const Text('Register Now'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildField({
    required String label,
    required String fieldName,
    required Function(String) onChanged,
    bool obscure = false,
    required IconData icon,
  }) {
    return ValidationWatcher(
      notifier: _form.validationNotifier,
      fieldName: fieldName,
      builder: (context, error) => TextFormField(
        onChanged: onChanged,
        obscureText: obscure,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          errorText: error,
        ),
      ),
    );
  }
}
