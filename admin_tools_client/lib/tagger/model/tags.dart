part of model;

class Tags{
  List<Tag> tags = [];

}

class Tag{
  int id;
  String name;

  void fromMap(Map tagData){
    id = tagData["id"];
    name = tagData["name"];
  }
}