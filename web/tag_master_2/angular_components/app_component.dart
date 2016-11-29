// Copyright (c) 2016, GrundL. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:angular2/core.dart';
import 'package:angular2_components/angular2_components.dart';

@Component(
    selector: 'my-app',
    styleUrls: const ['app_component.css'],
    templateUrl: 'app_component.html',
    directives: const[materialDirectives],
    providers: const [materialProviders])
class AppComponent {
  String path1 = "path1";
  String path2 = "path2";
  String path3 = "path3";
  String path = "";

  void setPath(String newPath) {
    path = newPath;
  }
}
