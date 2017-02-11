
import 'dart:convert';
import 'dart:html';
import 'package:angular2/core.dart';

import 'package:admin_tools/tagger/model/library.dart';
import 'package:admin_tools/tagger/server_gateway/requests.dart';
import 'package:admin_tools/tagger/services/user_service.dart';

@Injectable()
class EventsService {
  UserService _userService;
  GimmeEvents events;

  EventsService(this._userService){
    events = new GimmeEvents();
//    createMockEvents();
    HttpRequest.getString("assets/data.json").then((String content){
      Map pages = JSON.decode(content);
      pages.forEach((url,Map page){
        events.events.add(new GimmeEvent()..fromMap(page["event"]));
      });
    });
  }

  void createMockEvents(){
    Map event1Data = {
      "name": "Akce",
      "dateFrom": 1234553135573,
      "image": "image",
      "place": "Moje místo",
      "annotation": "Moje anotace sdfkljasflksdmf klasmdfkl asdmfkl asdmdfl ",
      "description": "Moje description dslfkjasdflkasdmn dlcfkasdm flkdsm fklmasd klfsdl kfklsj fsdkjf klsdjflk asjdfl",
      "sourceUrl": "http://www.ksdfaslfks.sdkfljas/lsdkfjasdlkf"
    };
    Map event2Data = new Map.from(event1Data);
    event2Data["name"] = "Moje jiná akce";

    GimmeEvent event1 = new GimmeEvent()..fromMap(event1Data);
    GimmeEvent event2 = new GimmeEvent()..fromMap(event2Data);
    events = new GimmeEvents();
    events.events.addAll([event1, event2]);
  }

  void saveEvent(GimmeEvent event){
    String token = _userService.user.token;
    uploadEvent(token, event.toMap());
  }
}