import 'package:flutter/services.dart';

class PhoneInput extends TextInputFormatter {
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      print(true);
      return newValue;
    }
    String newText = newValue.text;

    if (newValue.text[0] == "0") {
      newText = newValue.text.substring(1, newValue.text.length);
    }

    return newValue.copyWith(
        text: newText,
        selection: new TextSelection.collapsed(offset: newText.length));
  }
}
