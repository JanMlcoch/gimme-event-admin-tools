import 'package:angular2/core.dart';
import 'get_repo_service.dart';
import 'package:admin_tools/tag_master/library.dart';
import 'package:angular2_components/angular2_components.dart';
import 'dart:async';

@Component(
    selector: "quick-add-tag",
    templateUrl: 'quick_add_tag_component.html',
    directives: const [materialDirectives],
    providers: const [materialProviders])
class QuickAddTagComponent implements OnInit {
  final GetRepoService _repoService;
  QuickAddTagComponent(this._repoService);

  @Input()
  TagMasterRepository repo;

  bool isValid = false;
  String string;

  Tag createTagFromString(){
    int tagId = repo.getLowestUnusedTagId();
    Tag tag = new Tag.custom(tagId,string,0);//todo: authorId
    return tag;
  }

  void validate(){
    TagMasterRepository repoCopy =repo.copy();
    repoCopy.tags.add(createTagFromString());
    isValid = repoCopy.validate(rules: [new TagMasterRepositoryRule.uniqueTagNames()]);
  }

  //todo: doc
//  todo: + save?
  void submit(){
    repo.tags.add(createTagFromString());
    string = "";
    isValid = false;
  }

  Future<Null> ngOnInit() async {
    repo = await _repoService.getRepo();
  }
}
