- # Perform an RxJava => Reactor migration
- #
- The migration is currently cumbersome because we have to use our custom builds. Ideally this will not be necessary when we can upstream code.
	- For the migration we currently only support `maven` projects.
	- We heavily use automated formatting in our codebase, having the [fmt-maven-plugin](https://github.com/spotify/fmt-maven-plugin) installed helps a lot with the migration.
-
- Explanation of the steps and how it works:
- **Part 1, download and build repositories:**
	- 1. Check out [PicnicSupermarket/error-prone](https://github.com/picnicSupermarket/error-prone). 
	  2. Check out branch `rossendrijver/return_type`.
	  3. Build the code with `mvn clean install -DskipTests` (skipping tests to make it faster). There should now be a `HEAD-SNAPSHOT` version of Error Prone.
	  4. Check out [PicnicSupermarket/error-prone-support](https://github.com/picnicSupermarket/error-prone-support/). 
	  5. Check out the branch `rossendrijver/reactor_migration_setup` in `error-prone-support`.
	  6. Build the code with `mvn clean install -DskipTests`, it uses the Error Prone snapshot we just built. Now we have a `0.0.1-SNAPSHOT` version of Error Prone Support. 
	  7. Open the project that we want to add this migration tool to.
- **Part 2:** (this is required if Error Prone is not yet added to the codebase that we want to migrate)
	- Open the project and go to the `pom.xml`.
	- Add Error Prone and Error Prone Support to the build by doing the following:
		- Add the following dependencies:
		  ```
		  <dependency>
		    <groupId>tech.picnic.error-prone-support</groupId>
		    <artifactId>migration-util</artifactId>
		    <version>0.0.1-SNAPSHOT</version>
		    <scope>provided</scope>
		  </dependency>
		  ```
		- Add the dependencies listed below to the `annotationProcessorPaths`, see a different example [here](https://github.com/rickie/gravitee-access-management/commit/b143f108f578602d66812161ccaac294ab76c584#diff-9c5fb3d1b7e3b0f54bc5c4182965c4fe1f9023d449017cece3005d3f90e8e4d8R394-R452). Sometimes this means you even need to add a `<plugin>` section, see the former example.
		  ```xml
		  <path>
		    <groupId>com.google.errorprone</groupId>
		    <artifactId>error_prone_annotations</artifactId>
		    <version>${version.error-prone}</version>
		  </path>
		  <path>
		    <groupId>com.google.errorprone</groupId>
		    <artifactId>error_prone_core</artifactId>
		    <version>${version.error-prone}</version>
		  </path>
		  <path>
		    <groupId>com.google.errorprone</groupId>
		    <artifactId>error_prone_migration</artifactId>
		    <version>${version.error-prone}</version>
		  </path>
		   <path>
		     <groupId>tech.picnic.error-prone-support</groupId>
		     <!-- This is also an `error-prone-support` module that we import -->
		     <artifactId>error-prone-contrib</artifactId> 
		     <version>0.0.1-SNAPSHOT</version>
		  </path>
		  ```
		- Also Error Prone has to be configured, see [an example](https://github.com/rickie/gravitee-access-management/commit/b143f108f578602d66812161ccaac294ab76c584#diff-9c5fb3d1b7e3b0f54bc5c4182965c4fe1f9023d449017cece3005d3f90e8e4d8R394-R452), and another [example of a (WIP) config](https://github.com/rickie/gravitee-access-management/commit/acf7c355e4752aabdcab84635b86c83c4f872663#diff-9c5fb3d1b7e3b0f54bc5c4182965c4fe1f9023d449017cece3005d3f90e8e4d8R466): 
		  (Extra detail: we put this under a Maven profile called `error-prone`, it contains the plugin `maven-compiler-plugin` with the `annotationProcessPaths` and the Error Prone config.)
		  ```
		    <compilerArgs combine.children="append">
		      <!-- Enable and configure Error Prone. -->
		      <arg>
		      	-Xplugin:ErrorProne
		          -XepDisableAllChecks <!-- this is required if the codebase didn't use Error Prone before, there will be many violations because there are many, many checks -->
		  	    ... <!-- additional configuration -->
		          ${error-prone.args}
		       </arg>
		       <arg>-XDcompilePolicy=simple</arg>
		     </compilerArgs>
		  ```
		  And add the required dependencies ( [example](https://github.com/rickie/gravitee-access-management/commit/166b48f43e19e34170fbf68cce4a575307c764c9#diff-9c5fb3d1b7e3b0f54bc5c4182965c4fe1f9023d449017cece3005d3f90e8e4d8R370-R384) ):
		  ```xml
		          <dependency>
		              <groupId>com.google.errorprone</groupId>
		              <artifactId>error_prone_annotations</artifactId>
		              <version>HEAD-SNAPSHOT</version>
		          </dependency>
		          <dependency>
		              <groupId>com.google.errorprone</groupId>
		              <artifactId>error_prone_refaster</artifactId>
		              <version>HEAD-SNAPSHOT</version>
		          </dependency>
		          <dependency>
		              <groupId>com.google.errorprone</groupId>
		              <artifactId>error_prone_type_annotations</artifactId>
		              <version>HEAD-SNAPSHOT</version>
		          </dependency>
		  ```
		- And add a `patch` profile ( [example](https://github.com/rickie/gravitee-access-management/commit/166b48f43e19e34170fbf68cce4a575307c764c9#diff-9c5fb3d1b7e3b0f54bc5c4182965c4fe1f9023d449017cece3005d3f90e8e4d8R484-R499), don't forget [adding error-prone.args](https://github.com/rickie/gravitee-access-management/commit/166b48f43e19e34170fbf68cce4a575307c764c9#diff-9c5fb3d1b7e3b0f54bc5c4182965c4fe1f9023d449017cece3005d3f90e8e4d8R74) ):
		  ```
		  <profiles>
		          <profile>
		              <!-- If combined with the `error-prone` profile above, this profile
		              configures Error Prone to try and automatically fix (rather than
		              merely flag) bug pattern violations in the source code. -->
		              <id>patch</id>
		              <activation>
		                  <property>
		                      <name>errorprone.patchchecks</name>
		                  </property>
		              </activation>
		              <properties>
		                  <error-prone.args>-XepPatchChecks:${errorprone.patchchecks} -XepPatchLocation:IN_PLACE</error-prone.args>
		              </properties>
		          </profile>
		      </profiles>
		  ```
	- Run the following checks in `patch` mode and make sure they have no changes anymore. We later rely on these checks to clean up the code.
		- `CheckedExceptionNotThrown`
		- `UnnecessarilyFullyQualified`
		- `UnwrapExpressions` (provided by Error Prone Support)
		- `UnnecessaryMethodReference`
		- For Refaster we need this configuration: `-Xep:Refaster:ERROR -XepOpt:Refaster:NamePattern=.*RxJava.*`
		  We want to make sure that all `RxJava2Adapter` usages are (e.g.) of the form `RxJava2Adapter.monoToSingle` instead of `.as(RxJava2Adapter::monoToSingle)`. This makes the migration easier.
	- Turn off the following default Error Prone checks:
		- `MemberName` (by using: `-Xep:MemberName:OFF`)
		- `UngroupedOverloads`
		- `RemoveUnusedImports` --> For this we rely on the formatter `mvn fmt:format`. If that is not available we can do that at the end, but right now probably not in the same cycle.
	- Next, we can use the following command: `mvn -Perror-prone -Ppatch clean test-compile -Derror-prone.args='-XepDisableAllChecks -Xep:CheckedExceptionNotThrown:ERROR -Xep:UnnecessarilyFullyQualified:ERROR -Xep:UnwrapExpressions:ERROR -Xep:UnnecessaryMethodReference:ERROR`
	- By now, we should have a working Error Prone setup that can run the checks above. Now it is time to start the actual migration.
	-
- ## The migration script
- The migration script consists of five steps. We'll explain the steps, but the idea is that we can simply run the script by calling `./<name-of-file>.sh`. It must be placed in the root of the repository (or of the module/package) that we want to migrate or in the module that we want to migrate.
- There are still some (known) bugs that can occur and that prevents the script from completely running till the end.
	- Building the code will result in a compilation error and Maven will tell you where the error is and after fixing that, you can re-run the script.
	- All steps are run in a loop, till there are no more changes. Then it will continue with the next step.
- At the bottom there is an example of our `error-prone` Maven profile which might come in handy.
	-
- **Part 1:**
	- This part is the preparation phase. Using Refaster templates, we try to migrate the content of the method bodies as far as we can.
	- Make sure that the necessary dependencies are manually added to the `pom.xml` files of the modules that you want to migrate (can also be done one a project-wide level). This is not (yet) automated.
		- `reactor-addons` (for the RxJava2Adapter)
		- `reactor-core`
		- `reactor-test` (if there are tests in the module)
	- Automatically migrate the content of method bodies to Reactor. This means that RxJava usages are rewritten to their Reactor equivalent and wrapped inside `RxJava2Adapter` calls. An example is `Single.just(1)` will be translated to `RxJava2Adapter.monoToSingle(Mono.just(1))`.
	- In essence, the method bodies are now already migrated to Reactor. However, we didn't do anything with the return types _yet_.
	-
	- **Part 2**:
		- This part is the most important one and introduces the most changes.
		- 1. When we find a method with an RxJava return type then we (copy and then) introduce a new migrated method with a Reactor return type. We do this by converting the method body to Reactor by using an `RxJava2Adapter` call.  
		  2. However, if the method is defined in an interface, we first migrate the methods in the interface to Reactor. We do this by changing the interface. A duplicate (migrated) method is introduced with a default implementation that delegates to the original method. The original method from the interface is also changed to a default method and delegates to the new method.
		  3. Next, we use the [@InlineMe](https://errorprone.info/docs/inlineme) feature of Error Prone. In the first run, Error Prone adds the `@InlineMe` annotation to the `@Deprecated` methods (we introduced the `@Deprecated` annotations in the previous step). 
		  4. The `Inliner` will migrate all callers of the methods that we want to migrate. After running this, we now use the new Reactor method everywhere.
		- At this point, we introduced a lot of new code, but if things went correctly we now migrated all call sites and methods to Reactor.
		-
	- **Part 3:**
		- This part does the cleanup of all the unused RxJava methods, both in interfaces and classes.
		- Quite some code is deleted in this step. However, we should now end up with quite clean diffs.
		-
	- **Part 4:**
		- Extra step to rewrite lambdas to method references where possible.
		-
	- **Part 5:**
		- Final cleanup phase. Removing things like `UnnecessarilyFullyQualified` and `IdentityConversion`.
		-
	- **Part 6 (MANUAL STEP)**:
	- Finally, update the Javadocs using these commands (you may need to run the commands more than once):
	  ```bash
	  // These are here to update the Javadocs (run multiple times)
	  git ls-files '*.java' | xargs sed -i -r 's,(\*.*)(Flowable)(.*),\1Flux\3,g'
	  git ls-files '*.java' | xargs sed -i -r 's,(\*.*)(Observable)(.*),\1Flux\3,g'
	  git ls-files '*.java' | xargs sed -i -r 's,(\*.*)(Single)(.*),\1Mono\3,g'
	  git ls-files '*.java' | xargs sed -i -r 's,(\*.*)(Maybe)(.*),\1Mono\3,g'
	  git ls-files '*.java' | xargs sed -i -r 's,(\*.*)(Completable)(.*),\1Mono\3,g'
	  ```
	- Using the `Replace in files` feature from your IntelliJ, you can replace all `_migrated` strings with ``, just apply this to all matches. This is a left over thing of the migration.
	- This was the last step of the migration. There will be some things that still need some tweaking, we cannot migrate 100%. It can be a difficult thing to rewrite or we didn't add a Refaster template for that yet.
-
- The migration script:
	- ```
	  #!/usr/bin/bash
	  
	  set -e -u -o pipefail;
	  
	  # We use this internally to add JIRA tickets.
	  ticketnumber="" 
	  
	  part=1;
	  iteration=1;
	  
	  echo "The migration is starting:"
	  function run_migration_part_1 {
	    echo "############## Call patch, part $1, iteration $2 ##############"
	    mvn -T1C -Perror-prone -Ppatch clean test-compile -Derror-prone.args='-XepDisableAllChecks -Xep:CheckedExceptionNotThrown:ERROR -Xep:UnnecessarilyFullyQualified:ERROR -Xep:UnwrapExpressions:ERROR -Xep:UnnecessaryMethodReference:ERROR -XepPatchChecks:Refaster -XepPatchLocation:IN_PLACE -XepOpt:Refaster:NamePattern=.*ToReactor.*' -DskipTests -Dverification.skip;
	    mvn fmt:format
	  }
	  run_migration_part_1 $part $iteration
	  
	  while [ $(git status --porcelain | wc -l) -ne '1' ]
	  do
	    git add '*.java'
	    git commit -m "$ticketnumber P$part Run $iteration"
	    ((iteration=iteration+1))
	    run_migration_part_1 $part $iteration
	  done
	  
	  echo "Part 1 is done."
	  #################  SECOND PART OF MIGRATION ############################
	  ((part=2))
	  ((iteration=1))
	  
	  echo "Start part 2."
	  function run_migration_part_2 {
	    echo "############## Call patch, part $1, iteration $2 ##############"
	    mvn -T1C -Perror-prone -Ppatch clean test-compile -Derror-prone.args='-XepDisableAllChecks -Xep:CheckedExceptionNotThrown:ERROR -Xep:UnnecessarilyFullyQualified:ERROR -Xep:UnwrapExpressions:ERROR -Xep:UnnecessaryMethodReference:ERROR -Xep:InlineMeInliner:ERROR -Xep:InlineMeSuggester:ERROR -Xep:InlineMockitoStatements:ERROR -Xep:AddDefaultMethod:ERROR -XepPatchLocation:IN_PLACE' -DskipTests -Dverification.skip;
	    mvn fmt:format
	  }
	  echo "First iteration of the second part."
	  run_migration_part_2 $part $iteration
	  
	  while [ $(git status --porcelain | wc -l) -ne '1' ]
	  do
	    git add '*.java'
	    git commit -m "$ticketnumber P$part Run $iteration"
	    ((iteration=iteration+1))
	    run_migration_part_2 $part $iteration
	  done
	  
	  
	  echo "Start part 3."
	  ##################  THIRD PART OF MIGRATION ############################
	  ((part=3))
	  ((iteration=1))
	  
	  mvn -T1C -Perror-prone -Ppatch clean test-compile -Derror-prone.args='-XepDisableAllChecks -Xep:RemoveOldMethods:ERROR -XepPatchLocation:IN_PLACE' -DskipTests -Dverification.skip;
	  
	  mvn fmt:format
	  
	  if [ $(git status --porcelain | wc -l) -ne '1' ]; then
	    git add '*.java'
	    git commit -m "$ticketnumber P$part Run $iteration"
	    ((iteration=iteration+1))
	  fi
	  
	  echo "Start part 4."
	  ##################  FOURTH PART OF MIGRATION ############################
	  ((part=4))
	  ((iteration=1))
	  
	  mvn -T1C -Perror-prone -Ppatch clean test-compile -Derror-prone.args='-XepDisableAllChecks -Xep:MethodReferenceUsage:ERROR -XepPatchLocation:IN_PLACE' -DskipTests -Dverification.skip;
	  mvn fmt:format
	  
	  if [ $(git status --porcelain | wc -l) -ne '1' ]; then
	    git add '*.java'
	    git commit -m "$ticketnumber P$part Run $iteration"
	    ((iteration=iteration+1))
	  fi
	  
	  
	  echo "Start part 5."
	  ##################  FIFTH PART OF MIGRATION ############################
	  # Cleanup the code.
	  ((part=5))
	  ((iteration=1))
	  
	  function run_migration_part_5 {
	    echo "############## Call patch, part $1, iteration $2 ##############"
	    mvn -T1C -Perror-prone -Ppatch clean test-compile -Derror-prone.args='-XepDisableAllChecks -Xep:CheckedExceptionNotThrown:ERROR -Xep:UnnecessarilyFullyQualified:ERROR -Xep:UnwrapExpressions:ERROR -Xep:UnnecessaryMethodReference:ERROR -XepPatchChecks:Refaster -XepPatchLocation:IN_PLACE -XepOpt:Refaster:NamePattern=.*RxJava.*' -DskipTests -Dverification.skip;
	    mvn fmt:format
	  }
	  run_migration_part_5 $part $iteration
	  
	  while [ $(git status --porcelain | wc -l) -ne '1' ]
	  do
	    git add '*.java'
	    git commit -m "$ticketnumber P$part Run $iteration"
	    ((iteration=iteration+1))
	    run_migration_part_5 $part $iteration
	  done
	  echo "End of the migration."
	  ```
-
- Known limitations:
	- No support for migrating parameters
	- No support for migrating local variables
	- No support for migrating fields
	- No support for migrating methods in abstract classes
-
- For any questions, reach out to me on Slack. I'm happy to assist where possible.
-
- The `error-prone` Maven profile we use within Picnic:
	- ```
	  <profile>
	       <!-- An extension of the `build-checks` profile which configures
	       Error Prone. This configuration is defined in a separate profile so
	       that it can be combined with the `patch` profile below, without
	       introducing the overhead of other build checks. -->
	       <id>error-prone</id>
	       <activation>
	           <property>
	               <name>!verification.skip</name>
	           </property>
	       </activation>
	       <build>
	           <plugins>
	               <plugin>
	                   <groupId>org.apache.maven.plugins</groupId>
	                   <artifactId>maven-compiler-plugin</artifactId>
	                   <configuration>
	                       <annotationProcessorPaths combine.children="append">
	                           <path>
	                               <groupId>com.google.errorprone</groupId>
	                               <artifactId>error_prone_core</artifactId>
	                               <version>${version.error-prone}</version>
	                           </path>
	                           <!-- XXX: Error Prone relies on a more recent
	                           version of Guava than pulled in by Google Auto
	                           Service. Drop this dependency after the next
	                           Auto Service upgrade. -->
	                           <path>
	                               <groupId>com.google.guava</groupId>
	                               <artifactId>guava</artifactId>
	                               <version>${version.guava}</version>
	                           </path>
	                           <path>
	                               <groupId>org.mockito</groupId>
	                               <artifactId>mockito-errorprone</artifactId>
	                               <version>${version.mockito}</version>
	                           </path>
	                           <path>
	                               <groupId>tech.picnic.error-prone-support</groupId>
	                               <artifactId>error-prone-contrib</artifactId>
	                               <version>0.0.1-SNAPSHOT</version>
	                           </path>
	                       </annotationProcessorPaths>
	                       <compilerArgs combine.children="append">
	                           <!-- Enable and configure Error Prone. -->
	                           <arg>
	                               -Xplugin:ErrorProne
	                               <!-- We use a separate Maven profile to
	                               raise all warnings as errors. This way one
	                               can optionally collect all warnings without
	                               failing the build on the first error
	                               encountered. -->
	                               -XepAllErrorsAsWarnings
	                               <!-- We want to enable almost all Error
	                               Prone bug pattern checkers, so we enable
	                               all and then selectively deactivate some. -->
	                               -XepAllDisabledChecksAsWarnings
	                               <!-- Some generated classes violate Error
	                               Prone bug patterns. We cannot in all cases
	                               avoid that, so we simply tell Error Prone
	                               not to warn about generated code. -->
	                               -XepDisableWarningsInGeneratedCode
	                               -XepExcludedPaths:\Q${project.build.directory}${file.separator}\E.*
	                               <!--  Omitted some configuration from Picnic here  -->
	                               <!-- Append additional custom arguments. -->
	                               ${error-prone.args}
	                           </arg>
	                           <!-- The Error Prone plugin makes certain
	                           assumptions about the state of the AST at the
	                           moment it is invoked. Those assumptions are met
	                           when using the `simple` compile policy. This
	                           flag may be dropped after resolution of
	                           https://bugs.openjdk.java.net/browse/JDK-8155674. -->
	                           <arg>-XDcompilePolicy=simple</arg>
	                       </compilerArgs>
	                   </configuration>
	               </plugin>
	           </plugins>
	       </build>
	   </profile>
	   <profile>
	       <!-- If combined with the `error-prone` profile above, this profile
	       configures Error Prone to try and automatically fix (rather than
	       merely flag) bug pattern violations in the source code. -->
	       <id>patch</id>
	       <activation>
	           <property>
	               <name>errorprone.patchchecks</name>
	           </property>
	       </activation>
	       <properties>
	           <error-prone.args>-XepPatchChecks:${errorprone.patchchecks} -XepPatchLocation:IN_PLACE</error-prone.args>
	       </properties>
	   </profile>
	  ```