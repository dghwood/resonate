import 'package:flutter/services.dart';

class PhoneNumberFormatterUS extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final newText = newValue.text.replaceAll(
      RegExp(r'\D'),
      '',
    ); // Remove non-digits
    final textLength = newText.length;

    var usedLength = 0;
    final buffer = StringBuffer();

    // Limit to 10 digits
    final String digitsOnly =
        textLength > 10 ? newText.substring(0, 10) : newText;

    // Logic for 3-3-4 format: ###-###-####
    if (digitsOnly.length >= 1) {
      buffer.write(digitsOnly.substring(0, digitsOnly.length.clamp(0, 3)));
      if (digitsOnly.length > 3) buffer.write('-');
    }
    if (digitsOnly.length >= 4) {
      buffer.write(digitsOnly.substring(3, digitsOnly.length.clamp(3, 6)));
      if (digitsOnly.length > 6) buffer.write('-');
    }
    if (digitsOnly.length >= 7) {
      buffer.write(digitsOnly.substring(6, digitsOnly.length.clamp(6, 10)));
    }

    return TextEditingValue(
      text: buffer.toString(),
      selection: TextSelection.collapsed(offset: buffer.length),
    );
  }
}
