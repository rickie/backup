title:: Stephan Questions / 2022-08

-
-
- https://github.com/PicnicSupermarket/picnic-platform/pull/9190#discussion_r935669349
-
- background-color:: #787f97
- I don't think this one is easy, WDYT: [link](https://github.com/PicnicSupermarket/picnic-platform/pull/9203#discussion_r937455235)
- ```
  - return rankingResult.getSortedItemIds().stream()
  -        .flatMap(id -> Stream.ofNullable(articlesById.get(id)))
  -        .filter(articles::contains)
  -        .collect(toImmutableSet());
  +    return Sets.intersection(rankingResult.getSortedItemIds(), articles).immutableCopy();
  ```
-
-
- ~~Wat betreft de module voor TestNG -> JUnit, hoe pakken we dat aan? Het moet in principe wel gemerged worden.~~
-
-
- ~~Create a `patch-refaster.sh`~~
- ~~Dus de PR wordt eigenlijk heel makkelijk. Geen name pattern opgeven eigenlijk.~~
- ~~Kopieer het EPS patch script zonder zelfcheck naar picnic-scratch en daar staat default .* maar wel mogelijkheid tot overschrijven.~~
-
-
- ~~Gijs blijven? kunnen we wat aanbieden?~~
-
- {{embed ((62f2165d-ebbb-4aa3-8c28-95e67bc4a744))}}
- String als argument, als die 'n exceptie geeft. String.format zonder aguments; Welke exceptie komt er uit, als het een `...Exception` is, dan weet je of die wel of niet goed is.
- Iedree literal die je tegenkomt. string.format zonder argumenten aanroepen. Geen error, of hij geeft die  Conversion exception (assuming the left part is then correct); (ik mis een waarde) dan is het geldige format string is, als het samen geldig is, dan gaat iets na de + geen impact hebben, dan  moet je de plus niet gebruiken.
- Another example [link](https://github.com/PicnicSupermarket/picnic-distribution/pull/1255/commits/01e1e2729d5d390861373a147236fa64e12ea166#diff-95da1c56b0970be70108062110e0cba01b0cbf6e657fdc80d83e9a9d2343dc3cR477)
- Another example from [POM](https://github.com/PicnicSupermarket/picnic-pom/pull/2319/commits/2c18bb2397f4b541a2f71250a969a66c3e954fd3).
-
- Edge case @RequestParam:
	- https://github.com/PicnicSupermarket/picnic-pom/pull/2319/commits/1cea69c40a75899a1c0117ce6ed2927a99eb8a4c#diff-2c05372e45ba428d2f34baaad291ad413ab04b4c7f4cf23e37ca421955d14b27L258
-
- [link](https://github.com/PicnicSupermarket/picnic-distribution/pull/1255/commits/01e1e2729d5d390861373a147236fa64e12ea166#diff-e8eb22b009df9d0b415c1e647fb6120e86543ea8c348fa7c240d6b2e46f7321bR120) 
  
  ```java
   // XXX: PSM-XXXX: Fix BugCheck corner case
    @SuppressWarnings("Slf4jLogStatement")
    private Retry retryStrategy(PlanningStep<T> step) {
      return Retry.backoff(MAX_TRANSIENT_FAILURE_RETRIES, Duration.ofSeconds(1))
          .maxBackoff(Duration.ofMinutes(1))
          .filter(this::mayBeTransient)
          .doBeforeRetry(
              retrySignal ->
                  LOG.info("Will retry failed operation for '{}': {}", step, retrySignal.failure()));
    }
  ```
- dit moet zijn of getmessage; of toString() maar dan checken op throwable en de laatste, dan moet dat niet geflagd worden.
-
-
-
- ~~First release. Internal release.~~
- ~~This one is not on maven central .~~
-
-
- ~~This is the first release of Error Prone Support, for internal use at Picnic.~~
-
-
- ```
  [WARNING] /home/rick/repos/picnic-finance-invoicing/workday/workday-logic/src/test/java/tech/picnic/invoicing/workday/logic/mapping/WorkdayFileMappingTest.java:[21,20] [tech.picnic.errorprone.refastertemplates.AssertJTemplates.AssertThatMapIsNotEmpty2] 
    null
    Did you mean 'assertThat(mapping.getVat()).isNotEmpty()'?
  ```
-
- ```
  Optional<String> foo = Optional.of("foo");
  
  // original snippet
  if (foo.isPresent() && foo.orElseThrow().equals("bar")) {
    System.out.println(foo.orElseThrow());
  }
  
  // suggested snippet
  if (foo.filter("bar"::equals).isPresent()) {
    System.out.println(foo.orElseThrow());
  }
  ```
-
- TODO : ---> Actie Rick: Hier iets aan toevoegen, open PR van Stephan?
  :LOGBOOK:
  CLOCK: [2022-08-31 Wed 11:47:48]--[2022-08-31 Wed 11:47:49] =>  00:00:01
  :END:
-
- return buildSecription(tree)build(); #error-prone-support
- JAVA_OPTIONAL, of GUAVA; als het op de classpath is, dan omschrijven naar `OPtional.getClass().getName()` ipv `java.util.Optional`. #error-prone-support
-
-
- `UnaryFloatOperator`, I have a branch for that.
- ```
  [WARNING] /Users/loehnertz/Projects/Picnic/picnic-ws-replenishment/replenishment-logic/src/main/java/tech/picnic/replenishment/logic/MoveSuggestionService.java:[637,18] [LambdaFunctionalInterface] Use Java's utility functional interfaces instead of Function<A, B> for primitive types.
      (see https://errorprone.info/bugpattern/LambdaFunctionalInterface)
  it tells me.
  The signature of the flagged method is:
  public Float compute(Buffer buffer, Function<Float, Float> computation)
  But checking the JDK, there is no "utility functional interfaces" for Float :joy:
  https://docs.oracle.com/en/java/javase/17/docs/api/java.base/java/util/function/package-summary.html
  docs.oracle.comdocs.oracle.com
  java.util.function (Java SE 17 & JDK 17)
  declaration: module: java.base, package: java.util.function
  
  I would need a FloatUnaryOperator to make error-prone happy, but it simply doesn't exist
  grimacing
  
  Okay, using UnaryOperator<Float> works :thinking_face:
  ```
- [https://github.com/PicnicSupermarket/error-prone/blob/master/core/src/main/java/com/google/errorprone/bugpatterns/LambdaFunctionalInterface.java](Link to LambdaFunctionalInterface)
-
-
- DONE check platform Refaster templates
- Meerdere dingen reporten aan het _einde_ van EP, feedback David.
-
- https://github.com/PicnicSupermarket/picnic-tote-allocation/pull/490
-
- https://github.com/PicnicSupermarket/picnic-platform/pull/9367
-
- https://github.com/PicnicSupermarket/error-prone/pull/34
- https://github.com/PicnicSupermarket/error-prone/pull/35
-
- --> Create bug checker to ensure JUnit test classes are final
- --> **Gijs en setup voor TestNG migration**
	- Refaster rules, specifiek is voor library of migratie ofzo.
	-
-
-
- https://github.com/PicnicSupermarket/error-prone/pull/35
-
- https://github.com/google/error-prone/compare/master...PicnicSupermarket:error-prone:rossendrijver/bugs/ungrouped_overloads_records
-
- Nu hebben we TESTNG... BugPattern, klopt dat een beetje qua naam?
-
- TODO Thingy from Stephan
- .concatMap(e -> Mono.just(articlesById.get(e.getKey())).repeat((long) e.getValue() - 1)
- --> concatMapIterable, `ncopies` van die repeatvalue.
- REfaster Rule, om die Mono.just().repeat() --> Daarvan kan net zo goed, Mono.fromIterable() met `ncopies`.
- 2. De concatMap(),
-
- ~~1 test case wel flaggen `identification`, `replacement` 1 toevoegen, moet 2de test case niet? Even kijken wat ie doet.~~
- ~~NestedOPtionals equivalent.~~
-
-
- {{embed ((6310f938-cd12-41fa-9bc8-58136b17ec7f))}}
- logseq://graph/PKG?block-id=
- ~~Mening Stephan ^ [link](https://github.com/PicnicSupermarket/picnic-store/pull/1575#discussion_r941241080)~~
-
-
- https://github.com/PicnicSupermarket/error-prone-support/pull/28
-
- Structure.... TestNG. `error-prone-contrib`
-
-
- https://teampicnic.slack.com/archives/D03DZ9ZUHCM/p1662627183909109 --> Vincent `flatMap` `map` subscription.
-
-
-
- #### Reactie
- Als er gen curlies inzitten, schrijf javadoc `<code>` om naar @code.
- IsNull instead of EqualsNull
- IsNotNull
-
- # 14 de
- De new feature template... voor nieuwe check of juist EPS improvement general
-
-
- https://github.com/PicnicSupermarket/picnic-platform/pull/9414#discussion_r972843695 --> Enric en de `flatMapMany` met de `.flux()`.
-
-
- Run patch and skip EP as part of mvn clean install.
	- patch kan in principe weg
	- De refaster templates van PRP eigenlijk naar PSM.
	- Pas compiler plugin config in PSM aan. Voeg nog de refsaster templates toe die in PSM zitten aan het classpath.
		- Cycle....
		-
-
- Hoe gaan we het ooit doen met Reactor en TestNG things. Quality wise.
	- Bouwstenen, langzaam over, kijken hoe het kan gaan.
	- Maven invoker plugin;
	- Maven-arche-type plugin; vervolgens Maven build, met assertions over die build.
		-
-
- Phil
-
-
-
- Wat word de fallback als er geen `replacement` is?
-