UPDATE _TaggedEvent
SET eventJson =@u_eventJson :text, tagsJson =@u_tagsJson :text, updated =@u_updated :timestamp, userId =@u_userId :int4
WHERE _TaggedEvent.id = @_TaggedEvent_id :int8
RETURNING id, eventJson, tagsJson, created, updated, userId
{u_eventJson:{}, u_tagsJson:[{"id":1, "name":"pivo"}, {"id":2, "name":"larp"}, {"id":3, "name":"les"}], u_updated:2017-02-11 17:09:35.275736, u_userId:1, _TaggedEvent_id:1} -> [[1, {}, [{"id":1, "name":"pivo"}, {"id":2, "name":"larp"}, {"id":3, "name":"les"}], 2017-02-11 16:09:12.944319Z, 2017-02-11 16:09:35.275736Z, 1]]
