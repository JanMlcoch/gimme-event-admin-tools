import 'package:angular2/core.dart';
import 'get_repo_service.dart';
import 'package:admin_tools/tag_master/library.dart';
import 'package:angular2_components/angular2_components.dart';
import 'dart:async';
import 'package:angular2/router.dart';

@Component(
    selector: "edit-tag",
    templateUrl: 'edit_tag_component.html',
)
class EditTagComponent implements OnInit {
  final GetRepoService _repoService;
  final RouteParams _routeParams;
  EditTagComponent(this._repoService, this._routeParams);

  @Input()
  TagMasterRepository subRepo;

  Future<Null> ngOnInit() async {
    int _tagId = int.parse(_routeParams.get('tagId'), onError: (_) {
      throw new Exception("Parsing of tagId from routing parameters failed");
    });
    subRepo = await _repoService.getSubRepoOfTagId(_tagId);
  }
}
