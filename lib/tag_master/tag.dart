part of tagMaster2;

///Class representing tags
class Tag {
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
    if(authorId < 0)return false;

    return true;
  }
}
