import 'package:flutter/material.dart';

class AuthFormField extends FormField<String> {
  final bool obscureText;
  final bool validateOnBlur;

  AuthFormField({
    super.key,
    super.validator,
    super.onSaved,
    super.initialValue,
    String? hintText,
    TextInputType? keyboardType,
    void Function(String)? onChanged,
    bool hideErrorText = false,
    this.obscureText = false,
    this.validateOnBlur = false,
  }) : super(
          builder: (FormFieldState<String> genericState) {
            final state = genericState as _AuthFormFieldState;
            final hasError = state.hasError;

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
                    ? const Color(0xFF4A4E71)
                    : const Color(0xFF27B274),
              ),
              decoration: InputDecoration(
                hintStyle: const TextStyle(color: Color(0xFF6F91BC)),
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
                              ? const Color(0xFFFF8080)
                              : const Color(0xFF6F91BC),
                        ),
                        onPressed: () {
                          state.toggleObscure();
                        },
                      )
                    : null,
                filled: true,
                fillColor: hasError ? const Color(0xFFFDEFEE) : null,
                errorStyle: hideErrorText
                    ? const TextStyle(fontSize: 0, height: 0)
                    : const TextStyle(
                        color: Color(0xFFFF8080),
                        fontSize: 13,
                      ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: state.value == null ||
                          (state.value != null && state.hasError)
                      ? BorderSide.none
                      : const BorderSide(color: Color(0xFF27B274)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Color(0xFF6F91BC)),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: Color(0xFFFF8080),
                  ),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: Color(0xFFFF8080),
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
  bool _obscureText = true;
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
