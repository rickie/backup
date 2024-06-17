title:: Stephan Questions / 2022-03

- Previous: [[Stephan Questions / 2022-02]]
-
- Code review for `RefasterCollectionValidator`
	- https://github.com/PicnicSupermarket/error-prone-support/compare/rossendrijver/junit_extension_refaster_tests?expand=1
	- See: [[Refaster test extension]]
- `unusedVehicles.removeAll(getVehicles());` --> `getVehicles().forEach(unusedVehicles::remove);` code didn't work. `picnic-distribution`.
- Q: Would a Refaster template make sense here? 
  `Mono.just(x).map(X::method) -> Mono.fromSupplier(x::method).` [link](https://github.com/PicnicSupermarket/picnic-platform/pull/8660#discussion_r811888338) --> Not an option I think ? WDYT.
	- A: No we cannot do this automatically.
- Is it OK to close all `Dependabot` PRs in EP fork --> No
- The `not` here makes the `eq` required.
  ```java
  when(configurationRepository.get(not(eq(firstBatchLane.toString())), eq(BatchLaneConfig.class)))
          .thenReturn(BatchLaneConfig.of(true));
  ```
	- TIcket aanmaken.
- Should I open PR for this? https://groups.google.com/g/error-prone-discuss/c/W-53qb8jwhE
	- A: No too much hassle. Not worth the trouble, should be kept up-to-date probably.
-
- ## Nullable problem
  id:: 6259643c-2947-4b3f-af38-406f2c05142f
- NullableSTring aan `Optional.of`
	- methode zonder annotatie, methode met annotatei notnull.
	  id:: 625963df-88b5-443d-bb63-7f3171c57810
	- Optional.of() kan niet tnullable. #here
	  id:: 625963df-37ac-40f5-b3da-0e185f50b50c
	-
-
- ## 23 March
-
- https://github.com/PicnicSupermarket/picnic-java-support-modules/pull/663/files
- Bespreken initial setup EPS. Release, zien wat er **echt** moet gebeuren om het af te krijgen.
	- ~~https://github.com/PicnicSupermarket/picnic-java-support-modules/commit/fe26218b45fb6d95d70d071ebd1bb97e3b308acb~~
	- Release doen
	- Hoeveel trager wordt de build? Checken.
		- 39.0.5-SNAPSHOT --> 03:05 | 03:24 | 03:11
		- 39.0.0-SNAPSHOT --> 03:10?
	- ~~The volledgende regel.~~
		- ~~* op elke regel. Zo "normaal mogelijk comment".~~~~Prefix ipv postfix.~~
		- ~~Linewrappen? Google formatter.~~
- Feedback van Pieter bespreken:
	- ~~Feedback over de methods direct achter de MethodTree? --> Ziet het er daadwerkelijk beter uit als je een grote file hebt? Runt hij dan wel helemaal tot het einde? Of stopt 'ie eerder als je halverwege al een verschil tegen komt? __~~
- https://teampicnic.slack.com/archives/CEKRDL810/p1647962557771539
	- @Ignored moet er een associated XXX comment zijn.
	- Link to a ticket or move to the `manual` group. @Disabled
	- to collection arraylist new. tegen Patch zeggen optie 2. In release note run op deze manier patch 2.
- Summer bootcamp, what would be nice?
-
- Annotaties, TestNG -> JUnit
- PR openen voor AssertJ stuff.
	- Kijken of bestaat op internet. Flaggen en replacen, where possible, van `var` keyword.
		- Intersection types die niet denominatable zijn.
		- Var is not allowed, ka nniet
			- Algorithme gebruiken om te bepalen, local state. Wel moeilijk. Binnen 1 local scope.
-
- Have a JUnit extension that should help us with reducing boilerplate code and help us verify there have been no interactions with an `Answer`.
- Summary (From other ticket): in some cases it's convenient to be able to verify whether there have been interactions with an answer.
  For example, some methods may swallow exceptions or do something like `.onErrorResume(t -> Mono.empty())`, in which case the test would pass when it shouldn't. ([PSM-509](https://picnic.atlassian.net/browse/PSM-509))
  
  After discussing PSM-509 we had some rough ideas on how we could implement such a feature without using the `VerifiableAnswer` while also providing a way to reduce boilerplate code.
  
  This is some context on how that setup would look like:
  Using parameters for test methods and annotations on these methods we want to create a JUnit extension to provide a completely setup mock object. So if you add a parameter to a test method, the extension will provide that type as you want it set up. You can easily use it in the test as you would normally do. 
  
  The goal is that without having to change the Mockito "API" (as in, how we as Picnic use it), we can have similar functionality as the `VerifiableAnswer`. In the extension we can (e.g.) assert that some errors didn't happen or there was a subscriber to an object. For example, using an annotation we can determine how / what the extension should assert.
-
- ## 30 maart
- Ivan: Optional parameters at the end. `@InlineMe`? Or a check to just flag?
	- `UngroupedOverloads`. Inconsistent.
- https://github.com/PicnicSupermarket/picnic-corona-testing/pull/295/files#diff-a20d193404e08ab992c3d0d17c6236d5a96641923a7b09d61660e58ff42e9474R111 --> Luis
	- `assertWasSubscribed()`
- https://groups.google.com/g/error-prone-discuss/c/W-53qb8jwhE/m/B4iiUthnAgAJ?utm_medium=email&utm_source=footer&pli=1
- PSM :  @SuppressWarnings("ClassCanBeStatic" /* @Nested classes cannot be static. */)
  WebClientConfigTest --> JA
- ~~IdentityConversion.... (OK WSS verkeerd)~~
  ```
         SlotData slot = inv.getArgument(0);
                return ImmutableMap.copyOf(
                    Maps.filterKeys(
                        ImmutableMap.of(
                            PRIORITY_RESOURCE1,
                            slot.getFcId().getValue(),
                            PRIORITY_RESOURCE2,
                            slot.getDispatchPlanId()),
                        priorityResourceTypes::contains));
              })
              
              and DataProvider example:
  https://github.com/PicnicSupermarket/picnic-platform/pull/8816
  ```
- Dingen zoals POM waar we ff die suppress zullen moeten doen voor de abstract class. Willen we die nog snel fixen of? --> Liever wel, maar geen blocker.
- Maarten z'n vraag bekijken?
- Ik ben een PR vergeten. Wat dingen van PSM-1177.
- Typearguments; tests alleen voor 1 vd 2 (Fork).
-
-
- ## Questions
- See above....
- `collect(toImmutableSet())` rewrite, what would be alternative. ^^ticket%%
	- collect(toCollection(HashSet::new)) --> This is second option. 
	  toList also. ArrayList::new | HashMap
	- Java17 `stream.toList()`. Performance wise nog wat dingen. --> Uitstellen. #card
	  card-last-interval:: 4
	  card-repeats:: 1
	  card-ease-factor:: 2.6
	  card-next-schedule:: 2022-04-11T07:47:35.551Z
	  card-last-reviewed:: 2022-04-07T07:47:35.554Z
	  card-last-score:: 5
	-
- ~~https://github.com/PicnicSupermarket/picnic-java-support-modules/pull/1824#discussion_r842432130~~
- Ideas about the new modules setup.
	- Per tool/library?
	- Should we already take some effort on that?
- The recent PR I opened, what about that, is it OK? Think about implications.
	- A: Extra check maken om te kijken of ze niet nodig zijn.
		- Zonder K en vV wat zijn de upperbounds. Als type parameters niet de defualt zijn en
- Verify that `ParameterizedTests`-TestCases end with the suffix `TestCases` ???? --> Ook de annotatie doen. Rename there. TestCase method renaming annotatie ook renamen, en method zelf, andere JUnit features waarbij dat ook geld.
-
-
- REnovate: https://github.com/PicnicSupermarket/picnic-renovate/pull/69#discussion_r836563651
- Should the "once a month" Edge System rule also apply to Edge repos managed by Tech teams?
  What about picnic-tech-analysis-tech-edge?
-
-
-
-