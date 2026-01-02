import 'package:flutter/material.dart';
import 'package:aug_validateform/aug_validateform.dart';
import '../models/user_form.dart';
import '../widgets/primary_button.dart';
import '../widgets/custom_input_field.dart';
import '../widgets/custom_dropdown.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final UserForm _form = UserForm();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                // Red Wave Background
                Container(
                  height: 250,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(100),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 80, 24, 24),
                  child: Card(
                    elevation: 10,
                    shadowColor: Colors.black12,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            "Secure Account",
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Lorem ipsum dolor sit amet, consectetuer adipiscing sed diam nonummy nibh euismod tincidunt.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(height: 32),

                          // Birthday
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Birthday",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Expanded(
                                    child: ValidationWatcher(
                                      notifier: _form.validationNotifier,
                                      fieldName: 'day',
                                      builder: (context, error) =>
                                          CustomDropdown(
                                        label: "",
                                        hint: "Day",
                                        items: List.generate(
                                          31,
                                          (i) => "${i + 1}",
                                        ),
                                        onChanged: (v) => _form.day = v ?? "",
                                        value: _form.day.isEmpty
                                            ? null
                                            : _form.day,
                                        errorText: error,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: ValidationWatcher(
                                      notifier: _form.validationNotifier,
                                      fieldName: 'month',
                                      builder: (context, error) =>
                                          CustomDropdown(
                                        label: "",
                                        hint: "Month",
                                        items: [
                                          "Jan",
                                          "Feb",
                                          "Mar",
                                          "Apr",
                                          "May",
                                          "Jun",
                                          "Jul",
                                          "Aug",
                                          "Sep",
                                          "Oct",
                                          "Nov",
                                          "Dec",
                                        ],
                                        onChanged: (v) => _form.month = v ?? "",
                                        value: _form.month.isEmpty
                                            ? null
                                            : _form.month,
                                        errorText: error,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: ValidationWatcher(
                                      notifier: _form.validationNotifier,
                                      fieldName: 'year',
                                      builder: (context, error) =>
                                          CustomDropdown(
                                        label: "",
                                        hint: "Year",
                                        items: List.generate(
                                          50,
                                          (i) => "${2026 - i}",
                                        ),
                                        onChanged: (v) => _form.year = v ?? "",
                                        value: _form.year.isEmpty
                                            ? null
                                            : _form.year,
                                        errorText: error,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),

                          // Password
                          ValidationWatcher(
                            notifier: _form.validationNotifier,
                            fieldName: 'password',
                            builder: (context, error) => CustomInputField(
                              label: "Password",
                              placeholder: "••••••••••••",
                              onChanged: (v) => _form.password = v,
                              isPassword: true,
                              suffix: const Icon(Icons.lock_outline, size: 20),
                              errorText: error,
                            ),
                          ),
                          const SizedBox(height: 24),

                          // Phone Number
                          ValidationWatcher(
                            notifier: _form.validationNotifier,
                            fieldName: 'phoneNumber',
                            builder: (context, error) => CustomInputField(
                              label: "Phone Number",
                              placeholder: "1234 5678 9101",
                              onChanged: (v) => _form.phoneNumber = v,
                              prefix: Container(
                                width: 80,
                                padding: const EdgeInsets.only(left: 12),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.flag,
                                      color: Colors.blue,
                                      size: 20,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      "123",
                                      style: TextStyle(color: Colors.grey[600]),
                                    ),
                                    const Icon(
                                      Icons.keyboard_arrow_down,
                                      size: 16,
                                    ),
                                  ],
                                ),
                              ),
                              errorText: error,
                            ),
                          ),
                          const SizedBox(height: 24),

                          // Security Question
                          ValidationWatcher(
                            notifier: _form.validationNotifier,
                            fieldName: 'securityQuestion',
                            builder: (context, error) => CustomDropdown(
                              label: "Security Question",
                              hint: "Select a question",
                              items: [
                                "What is your pet's name?",
                                "Your first school?",
                                "City of birth?",
                              ],
                              onChanged: (v) =>
                                  _form.securityQuestion = v ?? "",
                              value: _form.securityQuestion.isEmpty
                                  ? null
                                  : _form.securityQuestion,
                              errorText: error,
                            ),
                          ),
                          const SizedBox(height: 16),
                          ValidationWatcher(
                            notifier: _form.validationNotifier,
                            fieldName: 'securityAnswer',
                            builder: (context, error) => CustomInputField(
                              label: "",
                              placeholder: "Your Answer...",
                              onChanged: (v) => _form.securityAnswer = v,
                              errorText: error,
                            ),
                          ),

                          const SizedBox(height: 48),
                          PrimaryButton(
                            text: "Create Account",
                            onPressed: () {
                              if (_form.validate()) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Account Created!"),
                                  ),
                                );
                              }
                            },
                          ),
                          const SizedBox(height: 16),
                          TextButton(
                            onPressed: () {},
                            child: const Text(
                              "Back to Login",
                              style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
