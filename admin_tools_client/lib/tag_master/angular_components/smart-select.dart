import 'dart:async';
import 'package:angular2/core.dart';
import 'package:angular2_components/angular2_components.dart';
import 'package:admin_tools/tag_master/angular_components/get_repo_service.dart';
import 'package:admin_tools/tag_master/library.dart';
import 'package:admin_tools/tag_master/smart_select/library.dart';

@Component(
    selector: "smart-select",
    templateUrl: 'smart-select.html',
    outputs: const ['onTagChosen'],
    directives: const [materialDirectives],
    providers: const [materialProviders /*, GetRepoService*/ /*, ROUTER_PROVIDERS*/])
class SmartSelectComponent implements OnInit {
  final GetRepoService _repoService;
  SmartSelectComponent(this._repoService);

  @Output()
  final onTagChosen = new EventEmitter<int>();

  @Input()
  List<int> allowedTypes = [1,2,3,4,5];

  @Input()
  List<int> excludedTagIds = [];

  @Input()
  bool shouldRemapSynonyms = true;

  @Input()
  String string = "";

  @Input()
  int chosenTagId;

  @Input()
  TagMasterRepository repo;

  bool shouldRenderOptions = true;
  List<LabeledTag> options = [];

  void updateOptions() {
    //todo:upgrade
    //todo: add excluded tagIds
    options = SmartSorter.getTags(string, repo, shouldReMapSynonyms: shouldRemapSynonyms);
  }

  void delayedBlur() {
    new Timer(new Duration(milliseconds: 500), () {
      shouldRenderOptions = false;
    });
  }

  void chooseOption(int tagId) {
    shouldRenderOptions = false;
    string = repo.getTagById(tagId).tagName;
//    string = "aaa";
    chosenTagId = tagId;
    onTagChosen.emit(tagId);
  }

  @override
  Future<Null> ngOnInit() async {
    repo = await _repoService.getWorkingRepo();
  }
}
