// Copyright (c) 2016, GrundL. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:angular2/core.dart';
import 'package:angular2/router.dart';
import 'package:angular2_components/angular2_components.dart';
import 'get_repo_service.dart';
import 'view_tags_component.dart';
import 'edit_tag_component.dart';

@Component(
    selector: 'my-app',
    styleUrls: const ['app_component.css'],
    templateUrl: 'app_component.html',
    directives: const [materialDirectives, ROUTER_DIRECTIVES],
    providers: const [materialProviders, GetRepoService, ROUTER_PROVIDERS])
@RouteConfig(const [
  const Route(path: '/view_tags', name: 'ViewTags', component: ViewTagsComponent),
  const Route(path: '/edit_tag/:id', name: 'EditTag', component: EditTagComponent),
  const Route(path: '/path2', name: 'Path2', component: Component2),
  const Route(path: '/path3', name: 'Path3', component: Component3),
])
class AppComponent {}

@Component(selector: "component2", template: 'Hello2')
class Component2 {}

@Component(selector: "component3", template: 'Hello3')
class Component3 {}
