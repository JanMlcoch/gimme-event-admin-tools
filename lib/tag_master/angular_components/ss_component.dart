import 'package:angular2/core.dart';
import 'get_repo_service.dart';
import 'package:admin_tools/tag_master/library.dart';
import 'dart:async';
import 'package:angular2_components/angular2_components.dart';
import 'package:admin_tools/tag_master/smart_select/library.dart';

@Component(
    selector: "smart-select",
    templateUrl: 'smart-select.html',
    directives: const [materialDirectives],
    providers: const [materialProviders/*, GetRepoService*//*, ROUTER_PROVIDERS*/])
class SmartSelectComponent implements OnInit {
  final GetRepoService _repoService;
  SmartSelectComponent(this._repoService);

  String _string = "";
  String get string => _string;
  set string(String value){
    _string = value;
    updateOptions();
  }

  @Input()
  TagMasterRepository repo;

  bool shouldRenderOptions = true;
  List<LabeledTag> options = [];
  int chosenTagId;

  void updateOptions(){
    //todo:upgrade
    options = SmartSorter.getTags(string,repo);
  }

  void chooseOption(int tagId){
    shouldRenderOptions = false;
    string = repo.getTagById(tagId).tagName;
    chosenTagId = tagId;
  }

  Future<Null> ngOnInit() async {
    repo = await _repoService.getRepo();
  }
}
