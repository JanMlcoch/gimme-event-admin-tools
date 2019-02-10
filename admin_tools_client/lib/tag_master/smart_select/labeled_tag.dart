part of tag_master_2.smart_select;

class LabeledTag extends Tag{
  String label;

  LabeledTag.fromTag(String label,Tag tag):super(){
    if(tag != null)fromMap(tag.toMap());
    this.label = label;
  }
}