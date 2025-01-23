import 'package:flutter/widgets.dart';
import 'package:test_assignment/features/authentication/presentation/auth_form_colors.dart';

class PasswordFieldRules extends StatelessWidget {
  final AuthFormColors formColors;
  final Iterable<String> rulesList;
  final GlobalKey<FormFieldState> fieldKey;
  final Map<String, String?> strengthCheckResults;

  // PasswordStrengthHints
  const PasswordFieldRules({
    super.key,
    required this.formColors,
    required this.rulesList,
    required this.fieldKey,
    required this.strengthCheckResults,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: rulesList
          .map(
            (rule) => Text(
              rule,
              style: TextStyle(
                fontSize: 13,
                color: strengthCheckResults.isEmpty ||
                        (strengthCheckResults[rule] != null &&
                            fieldKey.currentState?.hasError == false)
                    ? null
                    : strengthCheckResults[rule] == null
                        ? formColors.validGreen
                        : formColors.invalidRed,
              ),
            ),
          )
          .toList(),
    );
  }
}
