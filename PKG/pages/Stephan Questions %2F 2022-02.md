title:: Stephan Questions / 2022-02

- Q: Clashing static import `metaTextScore`, should we add this? 
  ```java
    .put("com.mongodb.client.model.Projections", "metaTextScore")
    .put("com.mongodb.client.model.Sorts", "metaTextScore")
  ```
- C: IsNullable example in EP -> Dive in
	- Hij heeft een match, en zegt dan laat maar.... Uplaceholderexpression. (regel 177 waarom gaat ie daarna naar Optional.absent().)
	- Waarom 2x in state?  De ExpressionTemplate is uiteindelijk leeg.
	- The problem is with the `@Matches` itself....
	-
	- UPlaceholderExpression.java regel 176 zit misschien wat. Want die states daar kloppen in principe gewoon...
	- `tryBindArguments` is null in this case
	- `FORBIDDEN_REFERENCE_VISITOR` accept, is `false`.....
	- `if (ImmutableSet.copyOf(state.seenParameters())` --> empty...
	-
	-
- D: The progress for the test plugin.
- D: Discuss `java.lang.Object` to `TypesWithUndefinedEquals`
	-
- Q: How far do you want to go with testing? -> Discuss
	- Use blocks? Make more beautiful
	- Denk mooi om lijstje te maken.
	- Source/main/java. PSM, test-support. Testcode die in src/main/java zit.
	  RefasterTemplatesTest moet weg uit die plek. Hoe doen met huidige test. 
	  Of naar andere module. heeft dependency op die module. Testcode geen gebruik van RefasterCheck. 
	  Die RefasterTemplates uit de module trekken. 
	  1 extra module, voor de test. Dependency is voor errorproncontrib.
	- Twee extra modules, de vorige + alle refaster templates hebt, dan kan die ook een dependency daarop. 
	  Refastertestsupport
	- Symmetric difference. En gewoon wat algemenere melding geven.
- Q: How can I build two versions of (e.g.) EPS? Is there a smart thing to do?
- Q: Discuss 2.11
- ```
   .collect(
              toImmutableListMultimap(
                  ConsentTextAssignment::getConsentTextId,
                  identity()))
  ``` 
  -> `getEnabledConsentRequests`
-
-
-
-