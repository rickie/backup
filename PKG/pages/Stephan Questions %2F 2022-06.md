title:: Stephan Questions / 2022-06

-
- https://github.com/PicnicSupermarket/error-prone/pull/32
	- ~~Unification~~Checker
	- ~~DubbelCheck dat is er niet 2x inkomt.~~
	- ~~`public`~~
	-
- ~~Brainstormen over Error Prone?~~
	-
-
- EP 2.14 upgrade
	- https://github.com/PicnicSupermarket/picnic-java-support-modules/pull/1718#discussion_r850512134
	- https://errorprone.info/bugpattern/NullableOnContainingClass --> Leads to many changes.
		- ~~interruption  -> uit zetten.~~
		- ~~Suppression; ticket for Immutable  (InvalidField) stuff.~~
		- ~~UnusedMethod aanzetten.~~
-
- ## "The problems"
- https://github.com/PicnicSupermarket/error-prone-support/pull/122#pullrequestreview-1000925340 (PR Resolve warnings)
-
- Volgende keer;
	- refaster-rule-selector
	- https://github.com/PicnicSupermarket/error-prone-support/pull/122#pullrequestreview-998289424 --> **Alles non-suggestion maken?**
		- Warning maken
		- Semantisch gezien geen warninggs. SUggestion alls warning? `AllChecksAsWarning`.
		- `AllSuggestionsAsWarnings`. ---> Created PR
	- ~~https://github.com/google/error-prone/issues/3255 (DefaultCharset).~~
-
- Do we want to open a PR for this? https://github.com/google/error-prone/issues/3144
  ( UnusedMethod Halil's ticket )
	- DONE PR aanmaken. issues/3144 EP
-
- https://github.com/PicnicSupermarket/error-prone-support/pull/58 (palantir baseline)
- ~~Discuss how to enable things in PSM right now.~~
-
- ~~Gijs access to PRP?~~ Fixed.
-
- https://errorprone.info/bugpattern/InlineMeValidator --> Iets voorstellen wat betreft MD?
	- Bugje? Omdat geen markdown file?
-
- ~~**EPS roadmap items?**~~
	- ~~Komt nog, eerst weer is dingen fixen.~~
-
- ~~Ferdinand's PR, I'm not sure about some things~~:
	- https://github.com/PicnicSupermarket/error-prone-support/pull/102/files
-
- # 20 juni
- ~~https://github.com/spotify/fmt-maven-plugin/compare/2.18.0...2.19.0 --> Version not up to date?~~
-
- Reverting would fix this right:
	- PR build-time template loading: https://github.com/PicnicSupermarket/error-prone-support/pull/121
		- En nog wat andere PRs.
		-
- ~~Empty line after class. Automate how? Reply to Ivan.~~
-
- ~~EP fork fixen~~
- ~~Discuss setup with `refaster` profile. --> Unblock.~~
- ~~Both EP upgrade PRs can be merged.~~
- ~~Also PSM-1299 go over it and discuss.~~
-
- - https://github.com/google/error-prone/issues/3297 --> link and say I'll open a PR?
-
- ## INVALID PARAMMMM
- https://github.com/google/error-prone/issues/2321 --> Branch `rossendrijver/invalidparam_records` wrong thing, not `error-prone` but `picnic-error-prone`.
- [Params compare](https://github.com/google/error-prone/compare/master...PicnicSupermarket:error-prone:rossendrijver/invalidparam_records)
-
- RECORD_FLAG is not so nice; ASSTHELPERs is record.
- Records ook typeparameters, add testcase.
- `.get(0)` --> hoe kan je de canonical constructor getten.
- multiple constructors. records.
-
- Last commit `return_type` met het runnen van `fast` is geeft het die JDk 17 bug dinges weer als error, why?
-
- https://github.com/PicnicSupermarket/picnic-platform/pull/9079#discussion_r900159391
-
-
-
- ~~Ja en flag support toevoegen. UnusedMethod.~~
-
-
- # ANNOTATION PROCESSOR PATH BUG
- Ook compatible met de fork.
- Een module met alleen de fork? Daar die tests runnen. Aware zijn dat een deel dus niet kan werken zoals het met de fork is.
-
- `mvn clean install -DskipTests -Dverification.warn -X -Perror-prone-fork | grep -oP '\-processorpath \S+' | xargs -d: -l1`
- mvn help:effective-pom | less
- -Dverbose | grep -v test | grep -v provided
-
- Hoe werkt maven dependency resolution.
- Hoe doen ze dat? Hoe werkt het algoritme.
- Maven core moet iets hebben.
- Maven compiler plugin, voor annotationprocessor classpath. Hoe doet ie dat.
- Vinden.
- Daarna, iets anders erin pluggen.
- Werkt goed voor main dependencies, en ook voor dependency plugin configuratie.
-
- De resolution moet gewoon verbeterd worden nu is het een zieke mess. Het is een soort depth first, which is not correct. Pulls in so many weird things.
-
-
-
- Alles naar boven verplaatsen zodat je de precedence kan bepalen is een soort van oplossing maar niet gewenst.
- Je hebt te weinig macht over wat er gebeurd. Niks over de order van de profiles.
-
- The order is simply so weird. Why does the 2.7.1 come before the 2.10? Why is resolution so weird?
- Why also 2.10, 2.2, 2.0.18
-
- plugin depdencny configuratie is de meer interessant versie van de code.
- Die code moet copy pasten, naar compiler plugin waar se iets doen met annotationProcessClasspath.
- JIRA ticket filen, heel goed uitleggen wat er mis gaat.
- Kleine POM
	- auto service
	- compilede verise van EP.
	- Daarna PR openen.
-
- Hoe gaan we compatibel shizz fixen.
- 1. Bepaalde APIs in 1 of ander bescvhikbaar zijn.
- 2. Hoe zorgen we dat we refaster framework, bridge thing, compatible met vanilla compiled templates als forked compiled templates.  Met de fork kan compilen en vanilla uitvoeren. Maar iig vanilla compile, dan de fork moet hem sws kunnen uitvoeren.
- Enige echte oplossing voor (2). Geshade versie maken van Onze fork, somehow, TBD, original EP en forked tegelijk op de classpath. beide aanroepen, 1ste als .refaster en tweede als .refaster2. (werkt niet want, for some reasons).
-
-
- Dit gaat gewoon sws problemen opleveren ook in PSM uiteindelijk.
- De 2.7.1 wordt ingepulled door auto-service. Omdat die een annotation niet heeft, geeft het bv geen problemen.
-
- `mvn clean install -DskipTests -Perror-prone -Dverification.warn -X | grep -oP '\-processorpath \S+' | xargs -d: -l1`
- ## Some findings
- With `maven-compiler-plugin` version 3.10.1 and 3.9.0
- ```
  rick@rick-picnic  ~/repos/error-prone-support/weird-classpath-issue   rossendrijver/pom ±✚  mvn clean install -DskipTests -Perror-prone -Dverification.warn -X | grep -oP '\-processorpath \S+' | xargs -d: -l1
  -processorpath /home/rick/.m2/repository/com/google/auto/service/auto-service/1.0.1/auto-service-1.0.1.jar
  /home/rick/.m2/repository/com/google/auto/service/auto-service-annotations/1.0.1/auto-service-annotations-1.0.1.jar
  /home/rick/.m2/repository/com/google/auto/auto-common/1.2/auto-common-1.2.jar
  /home/rick/.m2/repository/com/google/guava/guava/31.0.1-jre/guava-31.0.1-jre.jar
  /home/rick/.m2/repository/com/google/guava/failureaccess/1.0.1/failureaccess-1.0.1.jar
  /home/rick/.m2/repository/com/google/guava/listenablefuture/9999.0-empty-to-avoid-conflict-with-guava/listenablefuture-9999.0-empty-to-avoid-conflict-with-guava.jar
  /home/rick/.m2/repository/com/google/code/findbugs/jsr305/3.0.2/jsr305-3.0.2.jar
  /home/rick/.m2/repository/org/checkerframework/checker-qual/3.12.0/checker-qual-3.12.0.jar
  /home/rick/.m2/repository/com/google/errorprone/error_prone_annotations/2.7.1/error_prone_annotations-2.7.1.jar
  /home/rick/.m2/repository/com/google/j2objc/j2objc-annotations/1.3/j2objc-annotations-1.3.jar
  /home/rick/.m2/repository/com/github/PicnicSupermarket/error-prone/error_prone_annotations/v2.10.0-picnic-3/error_prone_annotations-v2.10.0-picnic-3.jar
  ```
-
- `maven-compiler-plugin` version 3.8.1:
- ```
  rick@rick-picnic  ~/repos/error-prone-support/weird-classpath-issue   rossendrijver/pom ±✚  mvn clean install -DskipTests -Perror-prone -Dverification.warn -X | grep -oP '\-processorpath \S+' | xargs -d: -l1
  -processorpath /home/rick/.m2/repository/com/google/auto/service/auto-service/1.0.1/auto-service-1.0.1.jar
  /home/rick/.m2/repository/com/github/PicnicSupermarket/error-prone/error_prone_annotations/v2.10.0-picnic-3/error_prone_annotations-v2.10.0-picnic-3.jar
  /home/rick/.m2/repository/com/google/auto/service/auto-service-annotations/1.0.1/auto-service-annotations-1.0.1.jar
  /home/rick/.m2/repository/com/google/auto/auto-common/1.2/auto-common-1.2.jar
  /home/rick/.m2/repository/com/google/guava/guava/31.0.1-jre/guava-31.0.1-jre.jar
  /home/rick/.m2/repository/com/google/guava/failureaccess/1.0.1/failureaccess-1.0.1.jar
  /home/rick/.m2/repository/com/google/guava/listenablefuture/9999.0-empty-to-avoid-conflict-with-guava/listenablefuture-9999.0-empty-to-avoid-conflict-with-guava.jar
  /home/rick/.m2/repository/com/google/code/findbugs/jsr305/3.0.2/jsr305-3.0.2.jar
  /home/rick/.m2/repository/org/checkerframework/checker-qual/3.12.0/checker-qual-3.12.0.jar
  /home/rick/.m2/repository/com/google/errorprone/error_prone_annotations/2.7.1/error_prone_annotations-2.7.1.jar
  /home/rick/.m2/repository/com/google/j2objc/j2objc-annotations/1.3/j2objc-annotations-1.3.jar
  ```
-
-
-
- # Next time
- Brainstorm about impact.. TestNg
-
- How can this work? https://picnic.atlassian.net/browse/PSM-1476
-
-
-
-
- QUotes zodat monospace.
-