library tagMaster2.tag;

///Class representing tags
class Tag {
  ///sometimes "comparable" might be used instead
  static const int TYPE_SYNONYM = 1;
  static const int TYPE_CUSTOM = 2;
  static const int TYPE_COMPOSITE = 3;
  ///sometimes "concrete" might be used instead
  static const int TYPE_SPECIFIC = 4;
  static const int TYPE_CORE = 5;

  String tagName;
  int tagId;
  int tagType;
  String lang;
  int authorId;

  void fromMap(Map<String, dynamic> map) {
    tagName = map["tagName"];
    tagId = map["tagId"];
    tagType = map["tagType"];
    lang = map["lang"];
    authorId = map["authorId"];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};

    map["tagName"] = tagName;
    map["tagId"] = tagId;
    map["tagType"] = tagType;
    map["lang"] = lang;
    map["authorId"] = authorId;

    return map;
  }

  bool validateLocally(){
    if(!(tagName is String && tagName != ""))return false;
    if(tagId == null)return false;
    if(tagId < 0)return false;
    if(!([1,2,3,4,5].contains(tagType)))return false;
    if(!(lang is String))return false;
    if(authorId == null)return false;
    if(authorId < -1)return false;

    return true;
  }
}
