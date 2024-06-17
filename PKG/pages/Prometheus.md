- portwarfard 8080:8080
- localhost:8080/prometheus/instance
- auth is the one that is about the logs whether it allows it.
- `kubectl logs pod name-of-pod --container proxy`
-
- `kubectl get {service,deployment} picnic-slot-service -o yaml | yq`
-
- auth is the one that is about the logs whether it allows it.
- `kubectl logs pod name-of-pod --container proxy`
-
- In Prometheus, look for "targets" and see the scrapers. / applications.
-
-
- min(value) by
-
- https://prometheus-prod.de.picnicinternational.com/graph?g0.expr=rule_engine_evaluation_queue%20%7B%20rule%20%3D%20%22fc_capacity_notification%22%7D&g0.tab=0&g0.stacked=0&g0.show_exemplars=0&g0.range_input=7h54m26s877ms&g0.end_input=2024-05-06%2000%3A00%3A29&g0.moment_input=2024-05-06%2000%3A00%3A29
- ```
  rule_engine_evaluation_queue { rule = "fc_capacity_notification"}
  
  rate(r2dbc_query_rules_seconds_sum 
       { query = "insertActionGroupExecution"}[5m]) / 
     rate(r2dbc_query_rules_seconds_count { query = "insertActionGroupExecution"}[5m]) 
     
  max(
    rate(r2dbc_query_rules_seconds_sum{query="checkDeduplicationPolicy"}[5m])
    /
    rate(r2dbc_query_rules_seconds_count{query="checkDeduplicationPolicy"}[5m])
  ) by (status)  
  ```