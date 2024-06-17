-
- For dropping some stuff in Rule Engine:
- ```
  db.getCollection("rule_engine_sync_claims").deleteOne({ "resource": "delivery_article_issues" });
  
  db.getCollection("rule_engine_sync_queue_delivery_article_issues").drop();
  # rule_engine_sync_queue_delivery_article_issues
  
  cursor...
  ```
-
-
- Query examples:
- ```
  db.getCollection("braze_sync_queue_user_profile").find({ "entity_id": 123 })
  
  ```
-
- ```
  .find({queue: {$ne:[]} }).count()
  
  // in Rule Engine (bridge-support), we have the `last_active_time` to check if we can 
  drop it maybe?
  
  .find({ last_active_time: {$lt: new ISODate('2024-03-01T00:00:00Z')} })
  
  .updateMany( 
   { last_active_time: {$lt: new ISODate('2024-03-01T00:00:00Z')} },
   {$set: {queue: []}}
   )
  
  ```
-