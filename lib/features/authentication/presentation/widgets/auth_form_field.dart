import 'package:flutter/material.dart';
import 'package:test_assignment/features/authentication/presentation/auth_form_colors.dart';

class AuthFormField extends FormField<String> {
  final bool obscureText;
  final bool validateOnBlur;

  AuthFormField({
    super.key,
    super.validator,
    super.onSaved,
    super.initialValue,
    required AuthFormColors formColors,
    String? hintText,
    TextInputType? keyboardType,
    void Function(String)? onChanged,
    bool hideValidatorErrorText = false,
    this.obscureText = false,
    this.validateOnBlur = false,
  }) : super(
          builder: (FormFieldState<String> genericState) {
            final state = genericState as _AuthFormFieldState;
            final hasError = state.hasError;

            final bodyLargeTextStyle =
                Theme.of(state.context).textTheme.bodyLarge!;

            return TextField(
              onChanged: (fieldValue) {
                state.didChange(fieldValue);

                if (onChanged != null) {
                  onChanged(fieldValue);
                }
              },
              keyboardType: keyboardType,
              focusNode: state.focusNode,
              obscureText: state._obscureText,
              style: TextStyle(
                color: state._hasFocus ||
                        state.value == null ||
                        (state.value != null && state.hasError)
                    ? bodyLargeTextStyle.color
                    : formColors.validGreen,
              ),
              decoration: InputDecoration(
                hintStyle: TextStyle(color: bodyLargeTextStyle.decorationColor),
                hintText: hintText,
                errorText: state.errorText,
                suffixIcon: obscureText
                    ? IconButton(
                        icon: Icon(
                          state._obscureText
                              ? Icons.visibility_off
                              : Icons.visibility,
                          size: 20,
                          color: state.hasError
                              ? formColors.invalidRed
                              : bodyLargeTextStyle.decorationColor,
                        ),
                        onPressed: () {
                          state.toggleObscure();
                        },
                      )
                    : null,
                filled: true,
                fillColor: hasError ? formColors.invalidLightRed : null,
                errorStyle: hideValidatorErrorText
                    ? const TextStyle(fontSize: 0, height: 0)
                    : TextStyle(
                        color: formColors.invalidRed,
                        fontSize: 13,
                      ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: state.value == null ||
                          (state.value != null && state.hasError)
                      ? BorderSide.none
                      : BorderSide(color: formColors.validGreen),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide:
                      BorderSide(color: bodyLargeTextStyle.decorationColor!),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: formColors.invalidRed,
                  ),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: formColors.invalidRed,
                  ),
                ),
              ),
            );
          },
        );

  @override
  FormFieldState<String> createState() => _AuthFormFieldState();
}

class _AuthFormFieldState extends FormFieldState<String> {
  bool _obscureText = false;
  bool _hasFocus = false;

  late FocusNode focusNode;

  AuthFormField get _widget => widget as AuthFormField;

  @override
  void initState() {
    super.initState();

    _obscureText = _widget.obscureText;

    focusNode = FocusNode();

    focusNode.addListener(() {
      setState(() {
        _hasFocus = focusNode.hasFocus;
      });

      if (_widget.validateOnBlur && !_hasFocus) {
        validate();
      }
    });
  }

  @override
  void dispose() {
    focusNode.dispose();

    super.dispose();
  }

  void toggleObscure() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
}
