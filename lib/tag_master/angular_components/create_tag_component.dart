import 'package:angular2/core.dart';
import 'get_repo_service.dart';
import 'package:admin_tools/tag_master/library.dart';
import 'package:angular2_components/angular2_components.dart';
import 'dart:async';
import 'package:angular2/router.dart';

@Component(
    selector: "create-tag",
    templateUrl: 'create_tag_component.html',
    directives: const [materialDirectives, ROUTER_DIRECTIVES],
    providers: const [materialProviders])
class CreateTagComponent implements OnInit {
  final GetRepoService _repoService;
  CreateTagComponent(this._repoService);

  @Input()
  TagMasterRepository subRepo;

  List<Relation> get relationsFrom => [];

  List<Relation> get relationsTo => [];

  Future<Null> ngOnInit() async {
    subRepo = await _repoService.getRepo();
  }
}
