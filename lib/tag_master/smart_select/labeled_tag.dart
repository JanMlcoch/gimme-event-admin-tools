part of tagMaster2.smartSelect;

class LabeledTag extends Tag{
  String label;

  LabeledTag.fromTag(String label,Tag tag):super(){
    if(tag != null)fromMap(tag.toMap());
    this.label = label;
  }
}