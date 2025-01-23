import 'package:flutter/material.dart';

class AuthFormColors extends ThemeExtension<AuthFormColors> {
  const AuthFormColors({
    required this.validGreen,
    required this.invalidRed,
    required this.invalidLightRed,
  });

  final Color validGreen;
  final Color invalidRed;
  final Color invalidLightRed;

  @override
  AuthFormColors copyWith({
    Color? validGreen,
    Color? invalidRed,
    Color? invalidLightRed,
  }) {
    return AuthFormColors(
      validGreen: validGreen ?? this.validGreen,
      invalidRed: invalidRed ?? this.invalidRed,
      invalidLightRed: invalidLightRed ?? this.invalidLightRed,
    );
  }

  @override
  AuthFormColors lerp(AuthFormColors? other, double t) {
    if (other is! AuthFormColors) {
      return this;
    }
    return AuthFormColors(
      validGreen: other.validGreen,
      invalidRed: other.invalidRed,
      invalidLightRed: other.invalidLightRed,
    );
  }
}
