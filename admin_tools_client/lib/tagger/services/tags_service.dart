import 'package:angular2/core.dart';

import 'package:admin_tools/tagger/model/library.dart';

@Injectable()
class TagsService {
  Tags tags;
  SmartSelectModel smartSelectModel;
  static int _incrementId = 0;

  TagsService(){
    createMockTags();
    smartSelectModel = new SmartSelectModel(tags.tags);
  }

  void createMockTags(){
    List<String> tagsStringData = ["tag1", "tag2", "superTag1", "superTag2", "bombaTag3", "bombaTag4"];
    List<Tag> tagsData = tagsStringData.map((String data) => new Tag()..fromMap({'name': data, 'id': _incrementId++})).toList();
    tags = new Tags();
    tags.tags = tagsData;
  }
}