import 'package:angular2/core.dart';
import 'get_repo_service.dart';
import 'package:admin_tools/tag_master/library.dart';
import 'dart:async';

@Component(selector: "view-tags", templateUrl: 'view_tags_component.html')
class ViewTagsComponent implements OnInit{
  final GetRepoService _repoService;
  ViewTagsComponent(this._repoService);

  @Input()
  TagMasterRepository repo;

  Future<Null> ngOnInit() async {
    repo = await _repoService.getRepo();
  }
}