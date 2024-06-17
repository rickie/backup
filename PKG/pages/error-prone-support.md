- [[RxJava to Reactor Migration manual]]
- [[Refaster test extension]]
-
- ^^Releasing:^^
- Milestone [0.1.0](https://github.com/PicnicSupermarket/error-prone-support/pulls?q=is%3Apr+is%3Aopen+sort%3Aupdated-desc+milestone%3A0.1.0)
-
- Remove final keywords from tests. Bugpatterns.
- One test with capital letter. Checkstyle thing?
- Use `nopen` in PSM? [nopen](https://github.com/JakeWharton/nopen).
-
- Maak ticket aan:
- - [OrElseGet thingy.]( https://github.com/PicnicSupermarket/picnic-java-support-modules/pull/2310/commits/bb261db5ebddc80ade5365645e52e3d420a69ba8)
- - POM PR.
-
- Other people:
	- Andrew: [https://github.com/PicnicSupermarket/picnic-store/pull/2549#discussion_r1189779950](https://github.com/PicnicSupermarket/picnic-store/pull/2549#discussion_r1189779950)
	-
-
- ## Todo's
- Simple TODO's
	- Add to  `TimeZoneUsage` check markdown: A rule of thumb: **the only method that should be applied on the clock object is ** `clock.instant()` . [link](https://picnic.atlassian.net/browse/WMS-2494?focusedCommentId=164006).
	- `plus(Duration.ofHours(1))` -> plusHours(1);
	- EPOCH
-
-
- https://picnic.atlassian.net/browse/PSM-2403?focusedCommentId=396687 --> NewRelic Scheduled annotation equivalent in Datadog.
-
- One thing we should perhaps do (in a separate PR) is document that Error Prone Support's Refaster rules are only compatible with the version of Error Prone against which they're compiled. Ideally we document that version on the website.
-
- StringCaseLocaleUsageCheck `String::toLowerCase` and `String::toUpperCase` [link](https://github.com/PicnicSupermarket/error-prone-support/pull/621/files#r1189481216).
-
- https://github.com/PicnicSupermarket/picnic-braze-bridge/pull/36#discussion_r1392414527 Enric: `doOnNext` -> `flatMap`
-
- ## New todos
- Add support to add your own staticIMport things. (FormattedNumberId)
-
- # ROADMAP
- ## Vision
- EPS als Platform
-
- Refaster performance
-
- Naming pattern
- Refaster templates uitzetten.
- Categorieen maken
-
-
- Blocked tickets niet builden.
- Short term ideas:
	- isPrimitive Matcher. (allebei boxed zijn is a? b :!b)
	- Allebei boxed, Object.equals(). a ? b : !b
	- IntelliJ doet ook zoiets, die doet het verkeerd zegt Stephan.
	-
- # Simple
- ~~`@JsonCreator(mode = JsonCreator.Mode.DELEGATING)` static import.~~
- Matchers renamen, suffixed with `_INVo`
- According to Javadoc of `AbstractThrowableAssert#hasCause`  assertThat(throwable).hasCause(null); // prefer hasNoCause() .
-
- https://github.com/highsource/maven-jaxb2-plugin/pull/211/files GH Actions PR
-
- Rewrites:
	- `ReactorCollectionWrapper`, `.flux(...).next`-> `.mono`. ([link](https://github.com/PicnicSupermarket/picnic-platform/pull/8660#discussion_r811889761))
	- ~~`joining("")` to `joining()` ([link](https://github.com/PicnicSupermarket/picnic-store/pull/1208#discussion_r816056875)) --> Pieter?~~
	- `.filter(Optional::isPResent).map(get?)` to `Mono::justOrEmpty` [link](https://github.com/PicnicSupermarket/picnic-platform/pull/8660#discussion_r814011080)
	- `ImmutableMap.<String, Boolean>builder().put(K,V).put(K,V).build())` --> To `ImmutableMap.of(K,V,K,V)`. ([link](https://github.com/PicnicSupermarket/picnic-platform/pull/8660#discussion_r816604101)). [Argument in different direction.](https://github.com/PicnicSupermarket/picnic-fca/pull/2885)
	- `concatMap(Flux::fromITerable)` -> `concatMapIterable(identity())` ([link](https://github.com/PicnicSupermarket/picnic-pom/pull/1961#discussion_r818794918))
	- `.max(comparing(Entry::getValue))` -> `.max(Entry.comparingByValue())` ([link](https://github.com/PicnicSupermarket/picnic-distribution/pull/1096/commits/25fc851b1eac9c33529fdf16b72e31dbcbc44bf2#diff-658bc5c76922b6decf7bed3ad7015bb710e6fba7113666e51c52174e317a74e7L65))
	- ` assertThat(out.size() > 0).isTrue();` -> `assertThat(out.size()).isPositive();` ([link](https://github.com/PicnicSupermarket/picnic-image-manager/pull/154#discussion_r827869148))
	- ~~Validate that `ParameterizedTests`-testcases have `TestCases` as suffix. ([link](https://github.com/PicnicSupermarket/picnic-platform/pull/8735#discussion_r828834006)) ~~
	- `Instant#plus(long, TemporalUnit)` --> `Instant#plus(Duration.ofMinutes(1))` ([link](https://github.com/PicnicSupermarket/picnic-platform/pull/8735/files/0d5f325960db419f5690e1eec0eef432df48ecb7#r828833351))
	- `wasSubscribed` --> `assertWasSubscribed` ([link](https://github.com/PicnicSupermarket/picnic-hcm/pull/360/commits/28bcb04597e51ca57fb10fbf39b86d3ba814eb93))
	- ~~UriBuilder usage of WebClient. Remove uriBuilder if not required. [PSM-1323](https://picnic.atlassian.net/browse/PSM-1323) [link](https://github.com/PicnicSupermarket/picnic-store/pull/1252/files/961be8962dcfcf2fed9041e15eee3f8d0cbe7fad#r830332245)~~
	- Remove `.this` where not required ([link](https://github.com/PicnicSupermarket/picnic-platform/pull/8779#discussion_r831062200))
	- Test Tag annotation group ([link](https://teampicnic.slack.com/archives/CEKRDL810/p1647962557771539)) --> Not what I think it is.
	- Enric's comment [link](https://github.com/PicnicSupermarket/picnic-platform/pull/8816#discussion_r837379201):
	  `.map(Optional::orElseThrow)` -> `.get()` ^^disuss
	  `.get().safisfies(` -> `.hasValueSatisfying(`
	- Werli `Optionals.mapBothPresent` thing ([link](https://github.com/PicnicSupermarket/picnic-platform/pull/8816#discussion_r837382589))
	- Werli: https://teampicnic.slack.com/archives/D01UN8G8U1L/p1648823445520959
	  `collect(toImmutableSet())`
	- `@TestInstance(TestInstance.Lifecycle.PER_CLASS)` --> Remove `TestInstance`. See POM `AbstractSingleSerializableDtoEntityTest`
	- `flatMap(cache -> Mono.justOrEmpty(...))` --> `mapNotNull(...)` [link](https://github.com/PicnicSupermarket/picnic-platform/pull/8878#discussion_r851248541)
	- ~~`.single()` isn't necessary; the `.collect` will always produce a value [link](https://github.com/PicnicSupermarket/picnic-platform/pull/8878#discussion_r851251422)~~
	- `.flatMap(list -> Flux.fromIterable(list))` -> `.flatMapIterable(Function.identity)` --> @Bastien maybe?
	- ~~`Objects.isNull(String str)` --> `str == null`; [link](https://github.com/PicnicSupermarket/picnic-java-support-modules/pull/1873#discussion_r867525150)~~
	- ~~`.method(PUT)` --> `.put()` [PSM-1430](https://github.com/PicnicSupermarket/picnic-store/pull/1400#discussion_r887741057).~~
	- ~~`BinaryOperator.minBy(naturalOrder())` -> `Comparators::min` [link](https://github.com/PicnicSupermarket/picnic-distribution/pull/1297#discussion_r980291779 )~~
	- Point input = Point.of((double) 1L, (double) 2L); --> after EP running 2.14
	- ~~Make sure `TestMode` is called on a `doTest` in EPS. ( [link](https://github.com/PicnicSupermarket/error-prone-support/pull/135#discussion_r901103871) ). Update: asked @Jean~~
	- Refaster templates, simplify `before2` names, if the overload is different. [link](https://github.com/PicnicSupermarket/error-prone-support/pull/129#discussion_r901137020).
	- https://github.com/PicnicSupermarket/picnic-stock-service/pull/639#discussion_r800466683
	  Hoepelman: `.map(Optional::orElseThrow)` --> `.flatMap(Mono::justOrEmpty)`
	  vergelijkbare regel; not functionaly equivalent. silently dropping element.
	  > Is it the same for `filter(Optional::isPresent).map(Optional::get)` -> `flatMap(Mono::justOrEmpty)` ?
	- `.onErrorReturn(ItemNotFoundException.class::isInstance, CacheState.ABSENT)` --> Drop `::isInstance` as it already happens. [link](https://github.com/PicnicSupermarket/picnic-java-support-modules/pull/1992#discussion_r917608596)
	- Enric mentions a AssertJ one with copyOf, [link](https://github.com/PicnicSupermarket/picnic-dwh-query-cache/pull/139#discussion_r1620830644)
	  `.containsExactlyInAnyOrderElementsOf(ImmutableList.copyOf(queryIds));` -> `containsExactlyInAnyOrder(queryIds);`
	-
	- Besproken met Ivan F: kunnen we checken of de `verifyComplete` vergeten is bijvoorbeeld?
	- ```
	     .filter(Optional::isPresent)
	     .map(Optional::get)
	     .findFirst());
	     
	     .filter(Optional::isPresent)
	     .findFirst()
	     .map(Optional::get);
	     
	     kan gewoon een flatMap worden van de Optional als het goed is.
	     https://github.com/PicnicSupermarket/picnic-wms/pull/2923/files#diff-b7805da8f7871848ee1a2f792dcfb8c26aa35265432df89f704491129d2623b1L171-R174
	  ```
	-
	- DeliveryFeedbackReportEventHandler
	  id:: 62f2165d-ebbb-4aa3-8c28-95e67bc4a744
	  
	  ```
	  @SuppressWarnings("FormatStringConcatenation")
	  private Mono<String> getImageUrlsLines(CustomerDeliveryReport report) {
	    return Flux._fromIterable_(report.getImageIds())
	        .map(imageId -> String._format_("    " + deliveryFeedbackBaseImagesUrl, imageId))
	  ```
	-
	- Edge case SLF4J BugPattern. 
	  ```
	  tech.picnic.asyncplanning.PlanningStepHandler#retryStrategy 
	  LINE 127
	  ```
	- ```
	  LOG.info("Will retry failed operation for '{}': {}", step, retrySignal.failure());
	  ```
	-
	- @RequestParam or @RequestAttribute, special case found by David.
	-
	- Others:
		- ~~Ivan; adding a missing AssertJThrowable withMessage template.~~
		- Shang: adding template to improve .map(Optional::IspResent.) `.filter(Optional::isPresent).map(Optional::get/orElseThrow`~~
	-
	- BP: Als er gen curlies inzitten, schrijf javadoc `<code>` om naar @code.
	- BP: `ImmutableSet<TabInterface>`, using the Immutables _definition_ here, is **not** correct. [link](https://github.com/PicnicSupermarket/picnic-platform/pull/9076#discussion_r898933806).
	- ~~BP: The opposite one of `StaticImport`.~~
	- ~~BP: Refaster templates modifiers: `static final class`. [example](https://github.com/PicnicSupermarket/error-prone-support/pull/245#discussion_r974141647).~~
	- BP & R: [PR comments Phil](https://github.com/PicnicSupermarket/picnic-platform/pull/9379#discussion_r986857638). `Optional#orElse(T)` -> `Optional#orElseGet(Supplier<T>)`.
	- BP: internal API endpoints should have a Swagger description rule. Be able to pass an argument to mark specific packages as _internal_ such that we know where to enforce this. [link](https://github.com/PicnicSupermarket/picnic-store/pull/1890/files#r1027268157). By Phil in the context of ArchUnit.
	- BP: Check that `this.` is not used outside of the constructor, and only if it actually necessary.
	- BP: Verify loggers use correct class. En they are psf.
	- BP: MongoDB checking equality also checks *order of fields*. Related [discussion](https://github.com/PicnicSupermarket/picnic-platform/pull/9116#discussion_r907586829).
	- BP: Newlines between `private static finals`, and `private final` [link](https://github.com/PicnicSupermarket/error-prone-support/pulls?q=is%3Apr+is%3Aopen+sort%3Aupdated-desc#discussion_r1070593113).
	- BP: Prefer wrapping `IOException` with `UncheckedException`. [link](https://github.com/PicnicSupermarket/error-prone-support/pulls?q=is%3Apr+is%3Aopen+sort%3Aupdated-desc#discussion_r1070599336).
	- BP: Look into the Logger BPs and improve them.
	- BP: Anti var check, remove `var` keywords.
	- BP: Check of @Var netjes weggehaald wordt.
	-
	- RR: [link](https://github.com/PicnicSupermarket/picnic-platform/pull/10130#discussion_r1188233693) Prefer `Streams.concat` over two `Stream.of`.
	- BP: Prefer `%n` over `\n` in `String#format` calls.
	- RR? `.merge(SuggestedFix.prefixWith(methodTree, "@Disabled\n"))` -->`.prefixWith(methodTree, "@Disabled\n")` on builder.  if there is like `addImport` before that one.
	- BP improvement: ValueSource; support meerdere: [link](https://github.com/PicnicSupermarket/picnic-platform/commit/cba2ac957003c42720952ba7ac454414701e4252#r115692187).
	- BP: Fix `ArgumentCaptor` usages [PR link](https://github.com/PicnicSupermarket/picnic-platform/pull/10204#issuecomment-1568225949).
	-
	- BP: Flag `try-catch` in tests as that can be replaced by something else from AssertJ.
	- BP: Move `@SuppressWarnings("unchecked")` closer to what it is supressing. [link](https://github.com/PicnicSupermarket/picnic-braze-bridge/pull/54#discussion_r1408023081)
	-
	- ###  # HARD
	- Detect logs just outside of a Reactive chain... [link](https://github.com/PicnicSupermarket/picnic-platform/pull/9148#discussion_r913596365).
	- [Discussion](https://github.com/PicnicSupermarket/picnic-platform/pull/9207#discussion_r935851116) which requires benchmarking: `.mapNotNull(category -> category.orElse(null))` vs. `.flatMap(Mono::justOrEmpty)` by @werli.
	-
	-
	-
	-
- ## Explanations of Error Prone Support
	- https://github.com/PicnicSupermarket/error-prone-support/pull/245#discussion_r974242723 --> `elidedTypesAndStaticImports`
	-
	-
	-
	-
- # EPS improvements
	- **Stephan thought**: Though perhaps we should add support for custom error messages to Refaster; this could be done by having RefasterCheck understand some custom annotation.
	- Renaming and sorting lexicographically; see whether a method has overloads, then include the parameter type(s) in those cases.
	- Check that Refaster templates are defined precisely in a subclass directly under a top-level class. [comment](https://github.com/PicnicSupermarket/error-prone-support/pull/43#discussion_r884277276).
	- Validate that `elidedTypesAndStaticImports` is minimal (and perhaps sorted?).
	-
	- BugPattern dingen:
		- ~~LexicographicalOrder -> `""` before `" "`~~
		- ~~FlatMapFluxUsage -> Exclude `GroupedFlux`~~
	-
	- ## Static Import #static-import
	- import static com.fasterxml.jackson.annotation.JsonInclude.Include.NON_EMPTY;
	- FixChoosers.FIRST
	- Description.NO_MATCH
	- @JsonFormat(shape = JsonFormat.Shape.NUMBER)	--> `JsonFormat.Shape.X`
	-
	- **Annotation-aware simplifier**
		- An annotation-aware (or context-aware) check that simplifies annotations.
			- An annotation-specific check could e.g. automatically simplify  `@JsonFormat(shape = JsonFormat.Shape.STRING)`  to  `@JsonFormat(shape = STRING)`  and  `@DateTimeFormat(iso = DateTimeFormat.ISO.DATE)`  to  `@DateTimeFormat(iso = DATE)` , because the attributes ( `shape`  and  `iso` ) match the constant's types ( `Shape`  and  `ISO` ).
		-
		-
	- ## Refaster templates
		- id:: 6310f938-cd12-41fa-9bc8-58136b17ec7f
		  ```
		  if (numberOfFoundKeywords > 1) {
		        throw new IllegalArgumentException(
		            "Unable to parse '%s', expected to have a single context definition node"
		                .formatted(nodeName));
		      } else {
		        return numberOfFoundKeywords == 1;
		      }
		    }
		    ==> 
		        long numberOfFoundKeywords = nodeMap.keySet().stream().filter(s -> s.startsWith("$")).count();
		      checkArgument(
		          numberOfFoundKeywords <= 1,
		          "Unable to parse '%s', expected to have a single context definition node",
		          nodeName);
		      return numberOfFoundKeywords == 1;
		    }
		  ```
		-
	- id:: 63032e6d-4875-4e4d-aeed-ccaee57fbfb7
	- Phil:
	- `Mono#just()`  will evaluate the parameter at assembly time. This is like declaring the parameter before the reactive chain.
	  In cases in which we still need to evaluate the parameter, we should be using  `Mono#fromSupplier()` .
	- cc [@rickie](https://github.com/rickie) Random thought: Is it possible to add an EP check for this? Along the lines of:
	- ```
	  if Mono#just()
	    if parameter still needs to be evaluated (i.e. is a method call (?))
	      rewrite to Mono#fromSupplier()
	  ```
	-
	-
	-
	-
	-
-
- # Error Prone improvements
	- BadImport fixen
	- UnusedMethod fixen ? Alles Jackson gerelateerd niet checken
	- Improve the `null` thingy that can occur when we show a Refaster match. `linkTextForDiagnostic`. [link to explanation](https://github.com/PicnicSupermarket/error-prone-support/pull/255#discussion_r984232347).
	-
	-
	- NullableMatcher fixen
	- NestedIdentifier probleem --> Notes met context
	  id:: 627a447f-6ebb-4f04-9597-b2ec3612bd2e
	-
	- [Link](https://github.com/PicnicSupermarket/picnic-platform/pull/8896#discussion_r857269568) `CLOCK.instant()` -> variable with `Instant NOW`.
	-
	- ## EPS
	- `Optional#orElse` should only be passed compile time constants [link](https://github.com/PicnicSupermarket/picnic-java-support-modules/pull/1785#discussion_r842677340).
	- AnnotationLexicographicalOrder --> `mode` and `value` being switched? Or Customer order? [link](https://github.com/PicnicSupermarket/picnic-java-support-modules/pull/1812#discussion_r841181297)
	- JUnitMethodDeclaration check - don't change modifiers in abstract class. [PSM-1322](https://picnic.atlassian.net/browse/PSM-1322)
	- Verify that `ParameterizedTests-TestCases` end with the suffix `TestCases`
	- Check of er een comment staat die de _juiste_ parameter namen list boven de Stream of arguments.
	- Always "call down". Will move many methods.
	- Enforce an empty field between static and instance fields [link](https://github.com/PicnicSupermarket/picnic-java-support-modules/pull/2023#discussion_r937712348).
	- Disallow two `.orElseThrow()` operations on one line of code as the error is not good [link](https://github.com/PicnicSupermarket/picnic-java-support-modules/pull/2023/files#r929872375).
	-
	-
-
- AssertJ rewrites:
	- ~~`isEqualTo(null)` --> `isNull()` --> Pieter?~~
	- ~~`.withMessage(String.format(...))` -> drop `String.format` ([link](https://github.com/PicnicSupermarket/picnic-salesforce-bridge/pull/473#discussion_r816028830)) [PSM-1320](https://picnic.atlassian.net/browse/PSM-1320)~~
	- ~~`.verifyErrorSatisfies(t -> assertThat(t).isInstanceOf(ItemNotFoundException.class));` -> `.verifyError(ItemNotFoundException.class);` ([link]([https://github.com/PicnicSupermarket/picnic-platform/pull/8717/commits/9c21d4689b1cd982f1cc843b4922b9c06835f0f1#diff-09303d6756087785db4b1dcc2fdd2268ae24f67bcdd14be1a79f927f1e42afe4L147](https://github.com/PicnicSupermarket/picnic-platform/pull/8717#discussion_r820895148))) [PSM-1321](https://picnic.atlassian.net/browse/PSM-1321)~~
	- Don't allow `verifyError()` without error ([link](https://github.com/PicnicSupermarket/picnic-platform/pull/8799#discussion_r835016642)) (Make this check more generic?)
	- ~~`assertThatIllegalArgumentException` should be rewritten to `assertThatThrownBy`. [link1](https://github.com/PicnicSupermarket/picnic-java-support-modules/pull/1772#discussion_r826854283) [link2](https://github.com/PicnicSupermarket/picnic-store/pull/1269#discussion_r839318103). [PSM-1310](https://picnic.atlassian.net/browse/PSM-1310)~~
	  id:: 62454b88-c193-428f-9c9e-465136de1bf1
	-
-
- CompilesWithFix() met inline replacement.
- De gehele migratie als stappenplan.
- Kan je compilesWithFix , dat je extra params meegeeft. Worst case de code copy pasten.
	- Kun je, cWF, bepaalde extra vlaggetjes meegeven om een bepaalde EP check die ook op classpath zit uit te voeren. En welke iteratie je zegt;
	- Hoe echt is de compilatie.
	- Kan met huidige compilesWithFix. Voeg als argument inplace patch toe.
	- Code met violation van hun check, dan opnieuw uitvoeren met IN_PLACE, nadat je check doet is code aangepast.
-
-