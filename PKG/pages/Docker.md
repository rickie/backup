- Here add docker stuff.
-
- List contents of docker image.
- https://stackoverflow.com/questions/44769315/how-to-see-docker-image-contents
-
- ### Important to login:
- cat ~/.docker/pwd.txt | sudo docker login --username 476rick --password-stdin
-
- # DOCKER!!! DROP STUFF
- docker system prune -a --volumes
- https://stackoverflow.com/questions/44785585/how-can-i-delete-all-local-docker-images
-
- ## Timeout???
- Geen idee precies, dkill, dc down, dc up? Docker login?
- #Commands
-
- `docker run -it teampicnic/picnic-spinnaker-cd:15.ca9167fa002430009c05b55bab5d9990095a1537.pull-95-head '--version'`
-
- `docker run --rm -v ~/.spin/config:/root/.spin/config rickie application list`
-
- `docker build -t rickie .`
- `docker run -it --entrypoint "" rickkert:v1 sh`
-
- Where rickkert:v1 is a version of the image.
- [Link](https://stackoverflow.com/a/42765465/4585226) :
- docker build -t image_name .
- ```
  docker run -d --name container_name image_name
  ```
-
- Docker-compose with interactive:
- ```
  docker-compose run --rm myapp
  ```
-
- If you want to remove a container/image that is stuck in  "Removal In Progress". Relevant SO answer: https://stackoverflow.com/a/68468090/4585226.
-
-
- # Component tests
- ```
  docker exec -t -i component-test-braze-bridge-1 /bin/sh
  
   curl http://localhost:8081/mng/health
  
  Outside of the container:
   curl -v http://localhost:7071/api/15/attributes -H "X-Picnic-ApiKey: 64c0548b48f9963837cd69e76111b4b52967f4ba888d06e5406dad920c650bb2"
  
  
  Extended version:
  curl -X POST http://localhost:8081/api/1/braze/proxy/send-push-message -H "X-Picnic-ApiKey: 64c0548b48f9963837cd69e76111b4b52967f4ba888d06e5406dad920c650bb2" -d '{"userDevices": {"100-000-0001": ["device_id1"], "100-000-0002": ["device_id2", "device_id3"]}, "body": "Your push message body goes here", "title": "Your push message title", "deeplink": "Your push message deeplink"}' -H "Content-Type: application/json" 
  
  ```
-
- Add logs and recompile.
- Jvm Debug