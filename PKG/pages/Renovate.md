- renovate namespace in global-dev
-
-
- How simple testing is:
- https://github.com/PicnicSupermarket/picnic-dwh-query-cache/pull/158#discussion_r1615617511
-
-
-
- Explanation Pieter on when it will open new PR:
	- If a new commit is on master, Renovate will automatically rebase in its next cycle. If one commits manually to the branch, Renovate will stop managing the branch, hence that Stephan did a few bumps himself here. Only way to get new updates while master did not change is to indeed close the PR and rename its title (which is too cumbersome and error prone to suggest). Solution is to just work harder and get more features out in master ;).
-
- ## Testing setup:
- ```
   ./test/start.sh pom.xml \
    <(./test/single-pom-dependency.sh org.openrewrite rewrite-templating 1.3.14)
  
  ```
-
- # rickie/renovate-testing
- When testing locally, make sure the `tmp/renovate-config.js` is an actual file and there are no warnings about it. Otherwise delete it.
-
- ```
  REPOSITORY="rickie/renovate-testing"                                                             
  RENOVATE_VERSION="35.111.0"
  TICKET="PSM-937"
  npm install --prefix config-generator
  npm start --prefix config-generator "${REPOSITORY}" "${TICKET}"
  docker run --rm --volume "/tmp/renovate-config.js:/usr/src/app/config.js" \
    --env LOG_LEVEL=debug \
    --env GITHUB_TOKEN="${GITHUB_TOKEN}" \
    --env NEXUS_USERNAME="${NEXUS_USERNAME}" \
    --env NEXUS_PASSWORD="${NEXUS_PASSWORD}" \
    --env DOCKERHUB_USERNAME="${DOCKERHUB_USERNAME}" \
    --env DOCKERHUB_PASSWORD="${DOCKERHUB_PASSWORD}" \
    renovate/renovate:"${RENOVATE_VERSION}"
    
   # Add this for suggested commit message:
  npm install --prefix suggest-commit-message
  npm run build --prefix suggest-commit-message
  node suggest-commit-message/dist/index.js "${REPOSITORY}" false none false
  ```
-
-
-
-
-
-
- Scale down renovate:
- `k -n renovate get deploy -l controller=eventsource-controller -o name | xargs -I {} kubectl -n renovate scale {} --replicas 0`
-
- ` kubectl get pods --context=picnic-global-dev -n renovate`
-
- ` kubectl logs --context picnic-global-dev -n renovate renovate-bot-argo-workflows-workflow-controller-fc7cdbdfd-mmv2w | grep -vE 'leases'`
-
-
- Applying Renovate stuff:
- `helmfile -f deployments/global-dev/renovate-bot/helmfile.yaml diff`
  Review output.
  If output is expected: `helmfile -f deployments/global-dev/renovate-bot/helmfile.yaml sync`
-
- Renovate test suggested commit message thing locally;
	- `$ GITHUB_TOKEN=$GITHUB_TOKEN npm run start -- PicnicSupermarket/picnic-runner-backend true`
	- Example by Pieter, [here](https://github.com/PicnicSupermarket/picnic-renovate/pull/92#issuecomment-1144709939).
-
- How check suggested commit messages:
	- (gegeven dat je al `npm i` hebt gedaan) In suggest-commit-message:
	  `GITHUB_TOKEN=$GITHUB_TOKEN npm run start -- PicnicSupermarket/picnic-runner-backend true`
	- `true` in dit geval is de `DRY_RUN`.
-
- Trigger Renovate for a repo [link](https://teampicnic.slack.com/archives/C032YK01DRC/p1654860391256209?thread_ts=1654851346.855219&cid=C032YK01DRC):
	- `ARGO_INSTANCEID=renovate-bot argo -n renovate submit --from=cronwf/picnic-ci-support`
-
- Command validate locally (from [Pieter's documentation](https://picnic.atlassian.net/wiki/spaces/~718927549/pages/3612573724/Handy+information+shortcuts) ):
- ```
  npm start --prefix config-generator PicnicSupermarket/picnic-wms PSM-937 && \
   sudo docker run --rm -v "/tmp/renovate-config.js:/usr/src/app/config.js" \
    -e LOG_LEVEL=debug \
    -e GITHUB_TOKEN=$GITHUB_TOKEN \
    -e NEXUS_USERNAME=$NEXUS_USERNAME \
    -e NEXUS_PASSWORD=$NEXUS_PASSWORD \
    -e DOCKERHUB_USERNAME=$DOCKER_USERNAME \
    -e DOCKERHUB_PASSWORD=$DOCKERHUB_PASSWORD \
    renovate/renovate:31.6.0 && \
    node suggest-commit-message/dist/index.js picnic-wms
  
  ```
-
-
-
- Delete origin things
- `git fetch <remote> --prune`
  id:: 62b41aae-287c-4d56-892e-3a1644b91b1a
-
- # TRIGGER
- ` [ARGO_INSTANCEID=renovate-bot argo --context picnic-global-dev -n renovate submit --from=cronwf/picnic-shortage-resolution-service`
-
-