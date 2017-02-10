// Copyright (c) 2016, GrundL. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:async';
//import 'package:angular2/platform/browser.dart';
//import 'package:admin_tools/tag_master/angular_components/app_component.dart';

void main() {
//  bootstrap(AppComponent);
  start().then((dynamic a) => print("dsfsf"));
  start().then((dynamic a) => print("dsfsf"));
  start().then((dynamic a) => print("dsfsf"));
  start().then((dynamic a) => print("dsfsf"));

}

Future start() async{
  count();
}

int factorial(int n) => n == 0 ? 1 : n * factorial(n - 1);

void count(){
  for (int i = 0; i <= 8000; ++i) {
    factorial(i);
  }
}


