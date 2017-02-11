@JS()
library selectize_lib;

import 'dart:math' as math;
import 'package:js/js.dart';
import 'package:angular2/core.dart';
import 'package:angular2_components/angular2_components.dart';
import 'package:angular2/common.dart';
import 'package:selectize/selectize.dart';

import 'package:admin_tools/tagger/services/tags_service.dart';
import 'package:admin_tools/tagger/model/library.dart';

@Component(
    selector: 'selective',
    template: r'''
      <div> {{selectedValue}}</div>
      <select  [ngClass]="classes" placeholder="Pick some people..."></select>

      <!--
      <select [ngClass]="classes"  multiple class="demo-default" style="width:70%" placeholder="Select a box...">
        <option value="">Select a box...</option>
        <option value="big">big</option>
        <option value="small">small</option>
      </select>
      -->
            ''',
    directives: const [
      NgClass
    ],
    providers: const [
      TagsService
    ])
class NgSelectize implements AfterViewInit, OnDestroy, OnInit {
  final TagsService _tagsService;
  ElementRef elelemtRef;
  NgZone zone;
  String selectedValue = 'c@a.com';
  List<String> classes;
  int _uniqueNs;
  Selectize _select;
  List<TagOption> options = [];

  Tags get tags => _tagsService.tags;

  NgSelectize(this.zone, this._tagsService);

//  var REGEX_EMAIL = r"([a-z0-9!#$%&\'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&\'*+/=?^_`{|}~-]+)*@" +
//      r"(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?)";


  ngOnDestroy() {
    _select.destroy();
  }

  ngOnInit() {
    _uniqueNs = new math.Random().nextInt(1000000000);
    classes = ["select-ag$_uniqueNs"];
  }

  ngAfterViewInit() {
    SelectOptions options = getSelectOptions();
    _select = selectize(".select-ag$_uniqueNs", options);

    _select.on('change', allowInterop((e) {
      zone.run(() => selectedValue = _select.items.toString());
    }));
  }

  SelectOptions getSelectOptions(){
    SelectOptions options = new SelectOptions(
        items: [selectedValue],
        maxItems: 3,
        valueField: "description",
        sortField: "description",
        labelField: "name",
        searchField: ['name', 'description'],
        persist: true,
        create: allowInterop((String input, Function cb) {
//          var reg = new RegExp(REGEX_EMAIL);
//          if (reg.hasMatch(input)) {
//            return new MailBaseOption(email: input);
//          }
          return new TagOption(name: input);
        }),
//        render: new RenderFuns(item: allowInterop((MailBaseOption item, escape) {
//          return '<div>' +
//              (item.name != null ? '<span class="name"> ${item.name} </span>' : '') +
//              (item.email != null ? '<span class="email"> ${item.email} </span>' : '') +
//              '</div>';
//        }), option: allowInterop((item, escape) {
//          return '<div>'
//              '<span class="label"> ${item.name ?? item.email}'
//              '</span>'
//              '</div>';
//        })),
//        options: [
//          new MailBaseOption(email: 'nikola@tesla.com', name: 'Nikola Tesla'),
//          new MailBaseOption(email: 'brian@thirdroute.com', name: 'Brian Reavis'),
//          new MailBaseOption(email: 'c@a.com')
//        ]));
        render: getRenderFuns(),
        options: getOptions()
    );
    return options;
  }

  RenderFuns getRenderFuns(){
    RenderFuns funs = new RenderFuns(item: allowInterop((TagOption item, escape) {
      return '<div>' +
          (item.name != null ? '<span class="name"> ${item.name} </span>' : '') +
          (item.description != null ? '<span class="description"> ${item.description} </span>' : '') +
          '</div>';
    }), option: allowInterop((TagOption item, escape) {
      return '<div>'
          '<span class="label"> ${item.name ?? item.description}'
          '</span>'
          '</div>';
    }));
    return funs;
  }

  List<TagOption> getOptions(){
    return tags.tags.map((Tag tag) => new TagOption(name: tag.name, description: "todo", id: tag.id)).toList();
  }
}

//class TagOption extends BaseOption {
//  int id;
//  String name;
//  String description;
//  TagOption({this.name, this.description, this.id});
//}

@JS()
@anonymous
class TagOption extends BaseOption {
  external String get description;
  external String get name;
  external int get id;
  external factory TagOption({String description, String name, int id});
}