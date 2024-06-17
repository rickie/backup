- Live prod debugging
-
- additionalJvmRuntimeOptions
-
- ```
  +java:
  +  additionalOptions: -agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=*:5050
  
  java:
    additionalOptions: -Dbridge.delivery-article-issues.queue.enabled=false
  
  e.g. selligent-bridge.values.yaml
  ```
-
- For Prod we need to enable the :
  `-agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=*:5005`
-
- See related Confluence page: https://picnic.atlassian.net/wiki/spaces/FCA/pages/3607068900/Attach+a+debugger+to+a+live+instance+of+an+application.
-
-