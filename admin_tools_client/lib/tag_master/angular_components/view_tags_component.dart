import 'dart:async';
import 'package:angular2/core.dart';
import 'package:angular2/router.dart';
import 'package:angular2_components/angular2_components.dart';
import 'package:admin_tools/tag_master/angular_components/get_repo_service.dart';
import 'package:admin_tools/tag_master/library.dart';

@Component(
    selector: "view-tags",
    templateUrl: 'view_tags_component.html',
    directives: const [materialDirectives, ROUTER_DIRECTIVES],
    providers: const [materialProviders/*, GetRepoService*//*, ROUTER_PROVIDERS*/])
class ViewTagsComponent implements OnInit {
  final GetRepoService _repoService;
  ViewTagsComponent(this._repoService);

  @Input()
  TagMasterRepository repo;

  void emptyRepo(){
    repo.tags = [];
    repo.relations = [];
  }

  void revert(){
    repo = _repoService.revertChanges();
  }

  void save(){
    _repoService.saveChanges();
  }

  @override
  Future<Null> ngOnInit() async {
    repo = await _repoService.getRepo();
  }
}
