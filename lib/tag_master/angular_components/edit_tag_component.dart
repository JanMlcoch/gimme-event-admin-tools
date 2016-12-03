import 'package:angular2/core.dart';
import 'get_repo_service.dart';
import 'package:admin_tools/tag_master/library.dart';
import 'package:angular2_components/angular2_components.dart';
import 'dart:async';
import 'package:angular2/router.dart';

@Component(
    selector: "edit-tag",
    templateUrl: 'edit_tag_component.html',
    directives: const [materialDirectives, ROUTER_DIRECTIVES],
    providers: const [materialProviders])
class EditTagComponent implements OnInit {
  final GetRepoService _repoService;
  final RouteParams _routeParams;
  EditTagComponent(this._repoService, this._routeParams);

  @Input()
  TagMasterRepository subRepo;

  List<Relation> get relationsFrom => subRepo.relations
      .where((Relation relation) => relation.originTagIds.single == subRepo?.tags?.first?.tagId)
      .toList();

  List<Relation> get relationsTo =>
      subRepo.relations.where((Relation relation) => relation.destinationTagId == subRepo?.tags?.first?.tagId).toList();

  Future<Null> ngOnInit() async {
    String _tagIdString = _routeParams.get('id');
    _tagIdString = _tagIdString != null ? _tagIdString : "";
    int _tagId = int.parse(_tagIdString, onError: (_) {
      throw new Exception("Parsing of tagId from routing parameters failed");
    });
    subRepo = await _repoService.getSubRepoOfTagId(_tagId);
  }
}
