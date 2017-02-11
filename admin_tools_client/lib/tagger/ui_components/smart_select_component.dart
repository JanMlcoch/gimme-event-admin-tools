//import 'dart:html';
//import 'package:angular2/core.dart';
//import 'package:angular2_components/angular2_components.dart';
//
//import 'package:admin_tools/tagger/model/library.dart';
//
//@Component(
//    selector: 'smart-select',
//    template: '''
//      <label for="eventTags">{{lang.smartSelect.tagsLabel}}*</label>
//      <div class="appSsTagContainer">
//          <div class="appChosenTagsTarget float-left" [hidden]="selectModel.chosenTags.isEmpty">
//            <div *ngFor="let tag of selectModel.chosenTags" class="appSsChosenTagCont appTag{{tag.id}}">
//              <div class="appSsChosenTagContainer">
//                {{tag.tagName}}
//                <button type="button" class="appRemoveChosenTagButton float-right" (click)="selectModel.removeChosenTag(tag)">X</button>
//              </div>
//            </div>
//          </div>
//          <div class="appSsTagActivePartsContainer">
//              <input type="text" class="appSsTagAutocomplete" [(ngModel)]="selectModel.substring" placeholder='{{lang.smartSelect.findTag}}'
//                (keyup)="handleInputKeyDown(\$event.keyCode)"/>
//              <div class="appSsTagOptionsTarget" [hidden]="selectModel.options.isEmpty">
//                <div *ngFor="let option of selectModel.options" class="appSsOptionCont appOption{{option.id}}">
//                    <div class="appSsOptionContainer" [class.appSsOptionActive]="selectModel.activeOption == option" (click)="handleOptionClick(option)">
//                      <div class="appTagNameInSsOption">{{option.tagName}}</div>
//                    </div>
//                </div>
//              </div>
//          </div>
//      </div>
//      <div class="errorMessage appSsTagValidatorMessage validatorMessage"></div>
//    ''',
//    styles: const ['''
//        #ssContainer {
//            width: 200px;
//        }
//
//        .appSsTagOptionsTarget {
//            position: absolute;
//            z-index: 100000;
//            background-color: white;
//            width: 200px;
//            border: 1px solid gray;
//        }
//
//        .appSsOptionContainer {
//            height: 25px;
//            padding: 4px 2px;
//        }
//
//        .appChosenTagsTarget {
//            border: 1px solid gray;
//            padding: 5px;
//            margin: 5px 0;
//            width: 500px;
//            height: 80px;
//            border-radius: 5px;
//            overflow-y: auto;
//        }
//
//        .appSsChosenTagCont {
//            display: inline-block;
//            margin: 0 3px 5px 0;
//            border: 1px solid gray;
//            padding: 2px 8px;
//            border-radius: 15px;
//        }
//
//        .appSsOptionContainer:hover{
//            background-color: #28aadc;
//        }
//
//        .appSsOptionActive {
//            background-color: #28aadc;
//        }
//
//        .appRemoveChosenTagButton {
//            width: 16px;
//            height: 16px;
//            margin: 1px 0 0 7px;
//            font-size: 7pt;
//            padding: 0;
//            border-radius: 8px;
//        }
//
//        .appTagLabelInSsOption {
//            font-size: 8pt;
//            font-style: italic;
//        }
//
//        .appSsOptionsOpen {
//            z-index: 10000;
//            min-width: 150px;
//            background-color: white;
//            position: absolute;
//            border: 1px solid gray;
//        }
//
//        .appTagNameInSsOption {
//            cursor: default;
//            padding: 1px 4px;
//        }
//      '''],
//    directives: const [
//      materialDirectives
//    ],
//    providers: const [
//      materialProviders
//    ])
//class SmartSelectComponent implements OnInit{
//  final ModelService _modelService;
//  Model get model => _modelService.model;
//  Lang get lang => _modelService.lang;
//  SmartSelectModel get selectModel => model.createEvent.smartSelectModel;
//
//  @Output()
//  final onChanged = new EventEmitter<List<Tag>>();
//
//  SmartSelectComponent(this._modelService);
//
//  @override
//  ngOnInit() {
//    selectModel.onChosenChanged.add(tagsChanged);
//  }
//
//  void tagsChanged(){
//    onChanged.emit(selectModel.chosenTags);
//  }
//
//  void handleInputKeyDown(int keyCode) {
//    if (keyCode == KeyCode.DOWN) {
//      selectModel.moveDown();
//    }
//    if (keyCode == KeyCode.UP) {
//      selectModel.onMoveUp();
//    }
//    if (keyCode == KeyCode.ENTER) {
//      selectModel.confirm();
////      validator.checkValidity();
//    }
//  }
//
//  void handleOptionClick(Tag tag){
//    selectModel.addChosenTag(tag);
//    selectModel.setActiveOption(tag);
//    selectModel.confirm();
//  }
//}