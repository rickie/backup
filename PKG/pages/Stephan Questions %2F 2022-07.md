title:: Stephan Questions / 2022-07

-
-
- # Questions:
- https://github.com/picnicSupermarket/error-prone/compare/master...rossendrijver/unusedmethod_improvements
	- https://github.com/PicnicSupermarket/error-prone/pull/34
	- https://github.com/google/error-prone/issues/3297 JPA things
	- https://github.com/google/error-prone/issues/3144#issuecomment-1166171830 Halil <3
	-
-
- maven depenency classpath.
- 2 verschillende poms.
-
- annotationProcessorPath, is from the `maven-compiler-plugin`. Plugin dependencies. The simplest thing.
-
-
-
- ## PSM-1299
- Platform `-DskipTests`
	- 03:51
- Platform (with latest EPS changes) `-DskipTests`
	- 04:39 min
-
- Normale patch (zonder -Prefaster)
	- 03:52
-
- # Next time
-
- https://github.com/PicnicSupermarket/picnic-platform/pull/9148#discussion_r913596365
	- Tagged in Reactor thing.
	- So a LOG#error statement inside a reactive chain...
-
-
- [Perform an RxJava =_ Reactor migration (1).md
- (../assets/Perform_an_RxJava_=_Reactor_migration_(1)_1657093922244_0.md)
-
- ~~Fix the fork by removing the commits.~~
-
- How fix EPS temporarily?
-
-
- ## Vragen
- JDK 17 in EPS
	- Multiline strings.
-
- Oleh DM sturen op Slack?
-
- ~~Samen over de Refaster performance praten.~~
-
-
- https://4comprehension.com/integrating-pit-mutation-testing-and-github-pages-with-github-actions/
- GHA !
- Hoe heb jij het het liefst voor je?
-
-
- AnnotationPosition... excluden als het een generated constructor is?
- Ik kom dit tegen:
- ```
  @Foo
  public <init>(String foo) {
      super();
  }
  ```
- Dat geeft fouten...
- This is the `ClassTree`
- ```
  class SimpleRecord { 
  	private final String foo;
  
    @Foo 
    public SimpleRecord(String foo) { 
    super(); 
    } 
  
  }
  ```
- In Error Prone:
	- `TreeScanner#visitClass` has a `node` that is complete, but then the `node.getMembers()` contains the `<init>` part..
	- [EP AnnotationPosition bug fix](https://github.com/google/error-prone/compare/master...PicnicSupermarket:error-prone:rossendrijver/bugs/annotation_position_records)
-
- Hij gaat in `JavacParser#recordDeclaration` en dan checkt 'ie, is het een recordstart, wat niet zo is, dus doet ie iets minder nice returnen.
-
- ### IsConstructorExplicit
-
- ### Ungrouped overloads
- For context, see `UngroupedOverloads#checkOverloads`.
- Same goes with this:
- ```
  MemberWithIndex{index=0, tree=
  public <init>(LocalDate date) {
      super();
  }}
  and
  MemberWithIndex{index=2, tree=
  public <init>(int year, int month, int day) {
      this(LocalDate.of(year, month, day));
  }}
  ```
- For this code: 
  ```
  import java.time.LocalDate;
  
  public record Bbd(LocalDate date) {
    public Bbd(int year, int month, int day) {
      this(LocalDate.of(year, month, day));
    }
  }
  ```
-
- ## Solution for all the record stuff!!!
- Try to find a different way to identify this stuff.
- It's not a generated constructor, so find other way, for example:
	- Sourceposition, NOPOS.
- https://github.com/PicnicSupermarket/error-prone/pull/35/files#diff-2050a0b77cde3ba1782b4351bd7002a4147d397cbc2d79d919e76d058ee75b27R257
- InvalidParam; normal constructor. Wat als ik name dan dus niet op schrijf. En haakjes.
	- dus Name wel in de javadoc niet in de constructor.
- ctor expleciet parameters weg.
- override, verschillend aantal argumenten.
- verschillende argumenten, 1 original, copy daarvan en default weglaat.
- lege
-
- tabelletje met permutaties.
-
- invalidparam permutaties,
- GroupedOverloads alle overloads checken.
-
- ### The reactor stuff solution: (possible/ only discussion)
- Returntype.
- Creatie van een nmono geen sideeffects.
-
-
-
-
- # Niet kunnen fixen:
- assertThatExceptionOfType(BadRequestException.class)
          .isThrownBy(BadfRequestException).withMessage()
-