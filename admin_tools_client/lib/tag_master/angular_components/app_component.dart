// Copyright (c) 2016, GrundL. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:angular2/core.dart';
import 'package:angular2/router.dart';
import 'package:angular2_components/angular2_components.dart';
import 'package:admin_tools/tag_master/repo/library.dart';

import 'package:admin_tools/tag_master/angular_components/get_repo_service.dart';
import 'package:admin_tools/tag_master/angular_components/view_tags_component.dart';
import 'package:admin_tools/tag_master/angular_components/edit_tag_component.dart';
import 'package:admin_tools/tag_master/angular_components/create_tag_component.dart';
import 'package:admin_tools/tag_master/angular_components/smart-select.dart';
import 'package:admin_tools/tag_master/angular_components/quick_add_tag_component.dart';

@Component(
    selector: 'my-app',
    templateUrl: 'app_component.html',
    directives: const [materialDirectives, ROUTER_DIRECTIVES, ViewTagsComponent, QuickAddTagComponent],
    providers: const [materialProviders, GetRepoService, ROUTER_PROVIDERS])
@RouteConfig(const [
  const Route(path: '/view_tags', name: 'ViewTags', component: ViewTagsComponent),
  const Route(path: '/edit_tag/:id', name: 'EditTag', component: EditTagComponent),
  const Route(path: '/create_tag', name: 'CreateTag', component: CreateTagComponent),
  const Route(path: '/smart_select_test', name: 'Path3', component: SmartSelectComponent),
  const Route(path: '/qat_test', name: 'Path4', component: QuickAddTagComponent),
  const Route(path: '/generic', name: 'Generic', component: EmptyComponent),
])
class AppComponent implements OnInit{

  final GetRepoService _repoService;
  AppComponent(this._repoService);

  @Input()
  TagMasterRepository repo;

  void emptyRepo(){
    if(repo==null)return;
    repo.tags = [];
    repo.relations = [];
  }

  void revert(){
    repo = _repoService.revertChanges();
  }


  @override
  Future<Null> ngOnInit() async {
    repo = await _repoService.getWorkingRepo();
  }
}


@Component(
    selector: 'empty',
    template: '',
    directives: const [],
    providers: const [])
class EmptyComponent{}