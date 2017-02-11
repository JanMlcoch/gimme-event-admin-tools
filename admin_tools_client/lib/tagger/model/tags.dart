part of model;

class Tags{
  List<Tag> tags = [];


  void fromList(List data) {
    for(Map tag in data){
      tags.add(new Tag()..fromMap(tag));
    }
  }
}

class Tag{
  int id;
  String name;

  void fromMap(Map tagData){
    id = tagData["id"];
    name = tagData["name"];
  }
}