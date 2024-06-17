- #[[Error Prone Workshop]]
-
- JFall pre-conference workshop
	- **masterclasses of 4 hours from top level speakers**
	- expert level
-
- Goals
	- Show power of Error Prone and Refaster
	- Cultural impact
	- Setting up as part of the build
	- How to write your own checks!
-
- A few different parts:
	- Problem statement & motivation
	- Introduction to Error Prone and Refaster
	- How to integrate  --> README
	- Build Refaster rule
	- Build Error Prone check
	- Play with your own check!
	- Applying within company.
-
-
- Things people will do themselves:
	- Improving code with Refaster, based on having a codebase with many "bad things".
		- Introducing EP(S) to a build.
		- Running command to apply vanilla Error Prone
	- Using Error Prone Support
		- Create your own Refaster rule to fix something from the "bad project"
		- Do a build and use that local version in the project
		- Run Error Prone to run it yourself.
	- OPTIONAL: Run it on your own codebase?
	- -
	- Now something for a simple BugPattern
	- -
	- Bring your own BugPattern
-
- Important:
	- Have Maven and Gradle setup.
	- Ask for feedback!
	- Tree Node en Symbol is a really important concept.
	- ASTHelper
-
-
- ## Right now
- Problem statement
- Picnic and its tools
- Endless discussions
-
- Introduction into Error Prone (high level)
	- Error Prone
	- Refaster
	- Demo
-
- Introduce EPS?
- First try (setting up)
	- Fork
	- Run the command.
-
- Explain Refaster
	- Deep dive
	- What are things that you can do?
-
- Workshop Refaster
	- Create 1 / 2 / 3 rules.
-
- Deep dive EP
	- Explain Error Prone
	- Do an example?
	- CompilationUnit level
	- Unsupported API
	- ASTHelpers
-
- Workshop Error Prone
	- Create a rule.
-
- Error Prone Support
- Applying EP(S) within your org
-
- Create time schedule.
-
- ## Schedule
-
- 40 min introduction + talk
- 20 first workshop
- 15 min break
- 15 min explain
- 30 min workshop Refaster
- 15 min explain
- 45 min workshop
- Laatste uitleg van EPS binnen Picnic toeapssen
- Vrij spelen
-
-
- Workshop
	- Setup fork and run integration test with first example.
	- Refaster
		- Re-use examples from existing codebase.
	- Error Prone
		- Logger stuff;
		- Dingen zoals EmptyMethod; Optional? Iets met types?
		-
	- Bring your own rule!
-
- Misschien nog een specifieke met staticimport als refaster rule?
- UTF_8?
-
- Wat denk je van de rules?
- Nog meer BPs toevoegen, welke ideeen hadden we?
-
-
- 11:15 - 11:45
- 13:15 - 13:36
- 14.19 - 15.45
- ==
- 2.5 hours
-
-
- Monday 3 hours
- Tuesday whole day
- Wednesday 4 hours
-
- Fr 3-10;
- 8.45 -
-
-
- Answers:
- Refaster rule number 5:
- ```
  //  abstract static class StreamAllMatch2<T> {
  //    @Placeholder(allowsIdentity = true)
  //    abstract boolean test(@MayOptionallyUse T element);
  //
  //    @BeforeTemplate
  //    boolean before(Stream<T> stream) {
  //      return stream.noneMatch(e -> !test(e));
  //    }
  //
  //    @AfterTemplate
  //    boolean after(Stream<T> stream) {
  //      return stream.allMatch(e -> test(e));
  //    }
  //  }
  
  ```