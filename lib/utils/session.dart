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

import 'dart:async';
import 'package:get_storage/get_storage.dart';

const String boxName = "SmartOfficeCustomer";

class Sessions {
  final storage = new GetStorage(boxName);

  Future<void> initialize() async {
    return GetStorage.init(boxName);
  }

  Future<bool> checkAuth() async {
    String token = storage.read("token");
    String user = storage.read("user");
    print(token);
    if (token != null && user != null) return true;
    return false;
  }

  Future<void> save(String key, String data) async {
    return storage.write(key, data);
  }

  Future<void> clear() async {
    return storage.erase();
  }

  String load(String key) {
    return storage.read(key);
  }

  Future<void> remove(String key) async {
    return storage.remove(key);
  }
}

final sessions = new Sessions();
