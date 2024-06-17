- Met Stephan over de extensie:
	- Structuur:
	  ```text
	  1 - error-prone-checks
	    - refaster-support
	     - refaster-resource-compiler
	     - refaster-error-prone-bridge (terrible name)
	     - refaster-test-support
	     - refaster-util (?)
	    - refaster-templates
	      - refaster-assertj-templates
	      - refaster-...-templates
	    
	    
	    - A: Refaster Compiler
	    - B: RefasterCheck
	    - C: "The test framework"
	      - Depends on B.
	    - D: Extra matches/predicate
	    - E: Template Set X
	      - Depends on B.
	      - Depends on C.
	      - Depends on D.
	  ```
	- De `RefasterCheck` moet naar z'n eigen module.
	- Error Prone branch maken met de change die we willen doen. Zorgen dat het daadwerkelijk goed werkt. Als we zeker zijn zou het nice zijn.
-
-
- Gesprek met Stephan
	- Code in verschillende modules zelfde package gebruikt. refaster-executor. errorprone tech errorprone bugpatterns.
	- Refastertemplate validaor, niet zelfde package, package uniek per module.
	- Validator, refastercheck wordt niet geimporteerd.  Zlefde package,
	- executor andere package.
	- lets to defer?; purpose van deze klasse, kleine dummy templates hebt, en dat je die alleen test dat ie die kan vinden bv. Dummy Refaster template, RCT kunnen checken dat ie die vind op classpath. En ook daadwerkelijk toepast. Exception message is zoals je zou verwachten. Coverage deel kan eruit. RefasterCheckTest produceert ook error message. Dat is er bijzonder aan. Je zou simpele test kunnen hebben, datie dingen flagt met clear message. Die template referenced. En dat ie een aanpassing maakt. A dingen van classpath laad, en ook toepast.
-
- To discuss with Stephan (9 March 2022):
	- Refaster-test-support --> refaster-test-util
	- Refaster-support -> refaster-util
	- RefasterCollectionValidator, good name? RefasterTemplatesTestValidator?
	- Who to ask for a review on this? Only you or?
	- `RefasterCheck` -> RefasterRunner? Should we do something with that name?
	- How to nicely print out the correct things? Go over tests?
	- How do we go from here?
-
- Feedback:
	- ~~refaster-support-test -> refaster.test~~
	- ~~CodeTransformersUtil -> drop Util~~
	- ~~ClassPath import the .RessourceInfo~~
	- ~~package-info met bugchecker is te specifiek~~
	- De list moet exhaustive zijn. 
	  Ticket aanmaken, om JUnit extension te maken die checkt dat je alle tests daadwerkelijk hebt.
	  Die obv classpath kijkt, zijn er "Templates" die in deze module zitten (en evt ook dat die class RefasterTemplates bevat), dan moet die in de specifieke test aanwezig zijn. Die test moet dus alle templates hebben, 1 parameterized test hebben, 1 methode aanroepen (namelijk `validateTemplateCollection`).
	- ~~RefasterTemplateValidator -> TestUtil~~
	- ~~Eigen visitor die deV methodes doorloopt. (NullAway supression kan dan weg)~~
	- ~~addOutputLines bekijken,~~
	- PR aanmaken met voorstel tekst. voor `inputAndOutput` `public` maken.
-
- Code from Demo:
	-
- ```java
  +import com.sun.source.tree.LineMap;
   import com.sun.source.tree.MethodTree;
   import com.sun.source.util.TreeScanner;
   import com.sun.tools.javac.tree.EndPosTable;
  @@ -198,6 +199,7 @@ public final class RefasterCollectionTestUtil {
           int startPosition = ASTHelpers.getStartPosition(tree);
           int endPosition = state.getEndPosition(tree);
   
  +        LineMap lineMap = state.getPath().getCompilationUnit().getLineMap();
           ImmutableRangeMap<Integer, String> matchesInCurrentMethod =
               matchesRangeMap.subRangeMap(Range.open(startPosition, endPosition));
           boolean correctTemplatesMatchedInMethod =
  @@ -206,7 +208,7 @@ public final class RefasterCollectionTestUtil {
             appendCommentToCompilationUnit(
                 String.format(
                     "The following matches occurred in method `%s` (position: [%s,%s])",
  -                  tree.getName(), startPosition, endPosition),
  +                  tree.getName(), lineMap.getLineNumber(startPosition), endPosition),
                 matchesRangeMap.asMapOfRanges().entrySet().stream()
                     .map(e -> "Template `" + e.getValue() + "` matched
                          
  ```
-
- ## Explanation
- Matching of match in correct method :
- ```
  We get a list of all the matches and go over each method in the file. A match has the
   name of the Refaster template and a position where it matched. Next, we visit each 
  ethod and retrieve the matches for that method, based on the start and end 
  position. We validate that the matches are from the correct Refaster template. 
  ```
-
- Could be a bit of over-explaining, (but want to be complete) the questions we should ask ourselves in this case;
  _ What is the purpose of what we are creating? 
  _ What is the added benefit of the extra code.
  _ Extra test code vs maintainability. 
  
  Not that all of these things are such a great deal in this case but all together I'd argue the following;
-
-
-
- ### Refaster test support
  
  This package provides utilities to validate Refaster template collections.
  
   What does it do?
  Ensures that each Refaster template has a test and has a match at the expected place.
  This extension guides the developer Using error reporting,
  
  How to set up ...?
  
  In summary, to test Refaster templates using the `RefasterCollectionTestUtil`, one should create an input and output
  file. The Refaster templates from the collection are applied on the input file and should exactly match the content of
  the output file.
  
  To use this setup, follow the next steps:
  
  _ Start with a Refaster template collection, which means a class that contains at least _one_ Refaster template. For a
    collection the naming convention is that it should end with `*Templates.java`.
    _ For each template collection there must exist an associated `*TemplatesTestInput.java` and `*TemplatesTestOutput.java`
      file.`
        
  
  During development report in the console where the results of the tests are shown.