- Bash commands:
	- for i in $(seq 1 7); do <command1> && <command2>; done && <final command?>
	- git --no-pager submodule foreach 'git grep -E "import static reactor.core.publisher" -- "*.java" || true'
-
-
- Replace some stuff:
- `git ls-files '*helm*' | xargs sed -i 's|14.0.0|14.1.0|g'`
- `git submodule foreach "git ls-files '*docker-compose*' | xargs sed -i 's|http://localhost:8200/v1/sys/health|http://127.0.0.1:8200/v1/sys/health|g' || true "`
-
-
- git --no-pager submodule foreach "git grep 'withPrefab' || true"
-
-
- `find . -name "*testco*" -delete -print`
-
- for i in $(find  . -maxdepth 1 -mindepth 1 -type d -print | grep -vendor); do ./generate-resources.sh $i;  ./apply-resources.sh $i;  done
-
- Kill IntelliJ --> `killall java -9`
-
- GIT PUSH -U
-
- # Maven
- `mvn -T 1.0C clean install -Perror-prone-fork -Pnon-maven-central -Pself-check -Ppatch -s settings.xml`
-
- `mvn clean compile -Dverification.warn -Perror-prone -Prefaster -Ppatch`
-
- `mvn test -pl messaging-support -Dtest="*ApplicationTest,DefaultRabbitMQ*" -Dsurefire.runOrder=reversealphabetical`
-
-
- ## Git
- Git rebase;
- `git rebase --onto newBase oldBase feature/branch`
- `git log -p -G salesforce` --> To go through git logs (also the contents)
-
- $ git grep -l --recurse-submodules com.tngtech.archunit -- '*pom.xml'
- `git grep com.google.common.base.Predicate -- '*.java'`
-
- https://teampicnic.slack.com/archives/C032YK01DRC/p1677657270717089?thread_ts=1677578804.210949&cid=C032YK01DRC
- `git rebase --onto=master x`
- x being a commit, see explanation.
-
- ```
  git log --grep=<pattern>
      Limit the commits output to ones with log message that matches the 
      specified pattern (regular expression).
  ```
-
-
- ### Fast-forward:
- **6.** ** Fast-forward **`master`** with the commits in **`feature-a`**.**
- Review the PR corresponding to `feature-a` which is targeting `master` (the build should be the exact same as that of the just merged `feature-b`). Now run `git checkout master && git pull && git merge --ff-only origin/feature-a`. Check your `git log` to see if the the two commits are added on top of what is in `origin/master`. These two commits should contain the same hashes as on `feature-a` and `feature-b` resp. This looks as follows:
- ![](blob:https://picnic.atlassian.net/143bf5b7-f4ec-4b55-bc32-c0411e24ea63#media-blob-url=true&id=118f0baf-086c-44b0-923c-d4475574c2ee&collection=contentId-4021649454&contextId=4021649454&height=194&width=527&alt=)
- Once the result looks good, run `git push` to push these two commits to `master`. The `feature-a` PR should be automatically closed.
-
-
-
- ---
-
- Account for java records when checking for unused variables
      
      resolves https://github.com/google/error-prone/pull/2515, resolves https://github.com/google/error-prone/issues/1648
-
- `npx prettier --write .` or `.` can be a file.
-
- ```
  git grep --recurse-submodules json-schema-validator
  ```
-
-
- `mvn -T1C -Perror-prone -Ppatch clean test-compile -Derror-prone.patch-args='-XepDisableAllChecks -Xep:CheckedExceptionNotThrown:ERROR -Xep:UnnecessarilyFullyQualified:ERROR -Xep:IdentityConversion:ERROR -Xep:UnnecessaryMethodReference:ERROR -XepPatchChecks:Refaster -XepPatchLocation:IN_PLACE -XepOpt:Refaster:NamePattern=.*RxJava.*' -DskipTests -Dverification.skip;`
-
- ## GH API
- `gh api -X GET search/code -f q="$(printf %s 'PSM-937 in:file org:PicnicSupermarket -filename:renovate*.values.yaml -filename:.renovaterc.json -repo:PicnicSupermarket/picnic-scratch' | jq -sRr @uri)"`
-
- ## Remote
- `git push -u rickie rossendrijver/upgrade_error_prone` to have a different remote.
-
-
- ## JMH Benchmark
- mvn process-test-classes -Dverification.skip \                         
                  -Djmh.run-benchmark=com.picnic.ranking.logic.ConfigurationSelectionBenchmark
-
- ## EPS Mutation tests
- ./run-mutation-tests.sh tech.picnic.errorprone.bugpatterns.EmptyMethodCheckTest
- ## Git submodules.
- `git submodule foreach --recursive git reset --hard`
  id:: 62bc3edd-55b1-4e05-be71-dac1cd90f837
- `git reset --hard --recurse-submodule` and
  `git submodule foreach git reset --hard`.
-
- If we want to update:
- `git submodule update --remote --recursive`
-
-
- [Link SO good reset](https://stackoverflow.com/questions/10906554/how-do-i-revert-my-changes-to-a-git-submodule)
- git submodule deinit -f .
  git submodule update --init
-
- ```
  #!/usr/bin/env bash
  
  set -e -u -o pipefail
  
  declare -a repositories=(
    picnic-forecast-dashboard
    picnic-java-all
    picnic-adjust-bridge
    picnic-after-care-service
    picnic-wms)
  
  #  result=${PWD##*/}
  #  if (( ${#repositories[@]} )) && printf '%s\0' "${repositories[@]}" | grep -zqxFe "$result"; then
  #      printf '%s\n' "$result in repositories"
  #    else
  #      echo "no"
  #    fi
  
  # shellcheck disable=SC2016
  #git submodule foreach bash -c "
  #  result=${PWD##*/}
  #  echo \"ressss: ${result}\"
  #  if (( ${#repositories[@]} )) && printf '%s\0' \"${repositories[@]}" | grep -zqxFe \"$result\"; then
  #    printf '%s\n' "$result in repositories"
  #  else
  #    echo "no"
  #  fi
  #
  #
  #  if [ -f pom.xml ]; then
  #    if git status | grep "nothing to commit, working tree clean" -q; then
  #      echo "No changes in submodule, skipping it."
  #    elif (( ${#repositories[@]} )) && printf '"'"'%s\0'"'"' "${repositories[@]}" | grep -zqxFe "${result}"; then
  #        printf  '"'"'%s\n'"'"' "$result in repositories"
  #
  ##    else
  ##      docker compose up -d rabbitmq || true
  ##      docker compose up -d postgresql || true
  ##      docker compose up -d mongodb || true
  ##
  ##      echo "Running build with all tests..."
  ##      mvn clean install -T1C -Dverification.skip -Drabbitmq.local=true &> build.log
  ##
  ##      if tail -n 10 build.log | grep "BUILD SUCCESS" -q; then
  ##        echo ">>>>>>> Build passed."
  ##      else
  ##        echo ">>>>>> Build failed. :(((("
  ##      fi
  ##      docker compose down
  #    fi
  #  fi
  #"
  
  ```
-
- git grep --recurse-modules directteksthier
-
-
- # Picnic-java-all
- `git grep --recurse-submodules -P 'search something here, no need for *'`
-
-
- # Run EPS Refaster profile
- `mvn -T 1.0C \                                    
  id:: 62ce6332-1b2a-402b-aab5-b1291195f788
    -Perror-prone \
    -Ppatch -Dverification.warn \
    clean test-compile -Prefaster -Dmaven.repo.local=/tmp/foobar`
-
-
- `mvn clean install -Derror-prone.refaster.name-pattern='.*' -DskipTests`
-
- ```
  git rebase --quit
  ```
-
-
- # Sed perl command
- `git ls-files '*.java' | xargs perl -0777 -pi -e 's/(class|interface|void)(.*\{\n)\n/\1\2/g'`
- `git ls-files '*.java' | xargs perl -0777 -pi -e 's/(private|public)(.*\(.*\).*\{\n)\n/\1\2/g' `
- `git ls-files '*.java' | xargs perl -0777 -pi -e 's/(class|interface|void|implements|extends)(.*\{\n)\n/\1\2/g'`
-
- `git ls-files '*.java' | xargs perl -0777 -pi -e 's/(.*\{\n)\n/\1/g'`
-
- Used perl instead of sed as it was easier to do so over multiple lines.
-
- ## Prettier
- `npx prettier --write --prose-wrap always README.md`
-
-
- # Component tests #Docker
- `docker compose --project-name component-test logs mockserver`
-
-
- # Picnic shared tools
- `git submodule update`
-