
import 'package:angular2/core.dart';

import 'package:admin_tools/tagger/model/library.dart';

@Injectable()
class EventsService {
  Events events;

  EventsService(){
    createMockEvents();
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

    Event event1 = new Event()..fromMap(event1Data);
    Event event2 = new Event()..fromMap(event2Data);
    events = new Events();
    events.list.addAll([event1, event2]);
  }
}