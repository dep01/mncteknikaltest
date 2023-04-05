/*
 * MIT License
 *
 * Copyright (c) 2020 Rizky Andhika Putra
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */

import 'dart:core';

class ValidationMixin {
  String validatePassword(String val) {
    if (val.isEmpty) {
      return "Required!";
    } else if (val.length < 6) {
      return 'Password minimum 6 characters!';
    }
    return null;
  }

  String validateConfPassword(String val, String val2) {
    var validate = validatePassword(val);
    if (validate == null) {
      if (val != val2) {
        return "Password Not Match!";
      }
    }
    return validate;
  }

  String validateEmail(String val) {
    final reg = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9-]+\.[a-zA-Z]+");
    if (val.isEmpty) {
      return "Required!";
    } else if (!reg.hasMatch(val)) {
      return "Invalid email format!";
    }
    return null;
  }

  String validateRequired(String val) {
    if (val == null || val.isEmpty) {
      return "Required!";
    }
    return null;
  }

  String validateRequiredInteger(int val) {
    if (val == null || val.isNaN) {
      return "Required!";
    }
    return null;
  }

  String validateRequiredNumber(String val) {
    if (val.isEmpty) {
      return "Required!";
    } else if (val.isNotEmpty && !isNumeric(val)) {
      return "Invalid Number!";
    }
    return null;
  }

  String validateNumber(String val) {
    if (val.isNotEmpty && !isNumeric(val)) {
      return "Invalid Number!";
    }
    return null;
  }

  bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }
}
