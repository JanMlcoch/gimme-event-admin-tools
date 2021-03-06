part of sidos.entities;

class FitIndex {
  double value;

  FitIndex(this.value);

  @override
  bool operator ==(dynamic fitIndex) {
    if (!(fitIndex is FitIndex)) return false;
    if (fitIndex == null) return value == null;
    return value == (fitIndex as FitIndex).value;
  }

  @override
  int get hashCode => value.hashCode;

  Map toMap() {
    return {"value": value};
  }

  void fromMap(Map map) {
    this;
    value = map["value"];
  }
}
