import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:test_assignment/features/authentication/presentation/auth_form_colors.dart';
import 'package:test_assignment/features/authentication/presentation/widgets/auth_form_field.dart';
import 'package:test_assignment/features/authentication/presentation/widgets/password_field_labels.dart';

typedef CustomFieldValidator = String? Function(String?);
typedef CustomFieldRules = Map<String, CustomFieldValidator>;

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final CustomFieldRules _passwordRules = {
    '8 characters or more (no spaces)': FormBuilderValidators.minLength(8),
    'Uppercase and lowercase letters': (candidateValue) =>
        FormBuilderValidators.hasUppercaseChars(atLeast: 1)(candidateValue) ??
        FormBuilderValidators.hasLowercaseChars(atLeast: 1)(candidateValue),
    'At least one digit': FormBuilderValidators.hasNumericChars(atLeast: 1),
  };

  final _formKey = GlobalKey<FormState>();
  final _emailFieldKey = GlobalKey<FormFieldState>();
  final _passwordFieldKey = GlobalKey<FormFieldState>();

  Map<String, String?> _passwordStrengthChecks = {};

  bool _checkPasswordStrength(String? fieldValue) {
    setState(() {
      _passwordStrengthChecks = Map.fromEntries(
        _passwordRules.entries
            .map((rule) => MapEntry(rule.key, rule.value(fieldValue))),
      );
    });

    return _passwordStrengthChecks.values.every((test) => test == null);
  }

  _showSuccessDialog() async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: const Text('Sign up success'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final formColors = Theme.of(context).extension<AuthFormColors>()!;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: const EdgeInsets.only(left: 30, right: 30, top: 194),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/auth_stars.png'),
            fit: BoxFit.contain,
          ),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFF4F9FF),
              Color(0xFFE0EDFB),
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Sign up',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 40),
                  AuthFormField(
                    key: _emailFieldKey,
                    hintText: 'Email',
                    keyboardType: TextInputType.emailAddress,
                    validateOnBlur: true,
                    formColors: formColors,
                    validator: FormBuilderValidators.email(
                      errorText: 'Invalid email address',
                    ),
                  ),
                  const SizedBox(height: 20),
                  AuthFormField(
                    key: _passwordFieldKey,
                    hintText: 'Create your password',
                    obscureText: true,
                    hideValidatorErrorText: true,
                    formColors: formColors,
                    validator: (fieldValue) {
                      return _checkPasswordStrength(fieldValue) ? null : '';
                    },
                    onChanged: (value) {
                      if (_passwordFieldKey.currentState?.hasError == true) {
                        _passwordFieldKey.currentState?.validate();
                      } else {
                        _checkPasswordStrength(value);
                      }
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, top: 8),
                    child: PasswordStrengthHints(
                      formColors: formColors,
                      rulesList: _passwordRules.keys,
                      fieldKey: _passwordFieldKey,
                      strengthCheckResults: _passwordStrengthChecks,
                    ),
                  ),
                  Center(
                    child: Container(
                      height: 48,
                      width: 240,
                      margin: const EdgeInsets.only(top: 40),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFF70C3FF),
                            Color(0xFF4B65FF),
                          ],
                        ),
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          FocusManager.instance.primaryFocus?.unfocus();

                          if (_formKey.currentState?.validate() == true) {
                            _showSuccessDialog();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          foregroundColor: Colors.white,
                          textStyle:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                        ),
                        child: const Text('Sign up'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
