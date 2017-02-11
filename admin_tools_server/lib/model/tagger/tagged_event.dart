part of admin_tools.model;

class TaggedEvent extends ManagedObject<_TaggedEvent> implements _TaggedEvent {
  @managedTransientOutputAttribute
  List<Map<String, dynamic>> get tags => tagsJson == null ? [] : JSON.decode(tagsJson);
  @managedTransientInputAttribute
  set tags(List<Map<String, dynamic>> tagsList) {
    tagsList ??= [];
    tagsJson = JSON.encode(tagsList);
  }

  @managedTransientOutputAttribute
  Map<String, dynamic> get event => eventJson == null ? {} : JSON.decode(eventJson);
  @managedTransientInputAttribute
  set event(Map<String, dynamic> eventMap) {
    eventMap ??= {};
    eventJson = JSON.encode(eventMap);
  }
}

class _TaggedEvent {
  @managedPrimaryKey
  int id;

  @ManagedColumnAttributes(unique: true, indexed: true, nullable: false)
  String eventJson; // JSONB

  @ManagedColumnAttributes(nullable: false)
  String tagsJson;

  @ManagedColumnAttributes(nullable: false)
  DateTime created;
  @ManagedColumnAttributes(nullable: false)
  DateTime updated;
  @ManagedColumnAttributes(nullable: false)
  int userId;
}
