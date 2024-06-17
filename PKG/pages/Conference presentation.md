- Do we want to talk about these two different parts? Or not really? That we really _add_ functionality or is it more important to show that we _can_ use EP and Refaster for the automation.
- What do we want to tell about validation?
-
- Can demo go in?
- Is there room for questions afterwards?
- Just to be sure: I _only_ need to do the recording right?
-
- Discussion, so mention code style? show the example of the test?
-
-
- Feedback:
	- ~~Take into account that no one knows the logos. Write the affiliations. For me both. Who am I? Bold faces.~~
	- ~~Drop virtual event.~~
	- ~~Introduction. EP github page. Remove that?~~
	- ~~Finish introduction, Slide with error prone.~~
		- ~~where does it come from~~
		- ~~What does it do. bullets.~~
	- ~~Refaster, also google project. Doesn't hurt to have it on the slide.~~
		- ~~speed up refaster part second image~~
-
	- Story change. Automate library migration. On a specific one
		- ~~Arrow between RxJava and Reactor. to the right.~~
		- ~~Running example for the automated migration~~
	- More about the work, not about the details. Extended it. tell that for sure.
	- Main motiviation is the validation results is not satifying.  but thenpositive
- ~~Conclusion and Future work on one slide.~~
- ~~Discussion -> Validation~~
- ~~Discussion split it to make it clearer. The scenario is not clear. Swap total, with extensions. Total can goes away. Drop "part 1" "part 2". RxJava -> Reactor without extensions.~~
	- ~~Overlay it at the left bottom side. Bulletpoints, Industrial vs opensource~~
- Lame; lot of text hard to grasp, more clear, say we are awesome in.Need _only_ Refaster knowledge.
-
- Important relevant.  often used. New hot library Reactor. Real problem, migrating all RxJava code costs a lot of time.
- Key point; write a tool for that.two tools that are not specifically written for this purpose, we reuse them to our benefit.
-
- DONT EXPLAIN DETAILS.
-
- Lib migration principle, RxJava introduce logog's must make sure that this particular mig is a relevant one.
-
- ## The setup
- Introduction
	- What is the problem?
	- What do we want to do?
	- How?
		- Consider suitability of EP and Refaster
- Explain tools
- We focus on a specific migration, RxJava to Reactor, two libs for reactive programming.
- How does the migration work
	- Compilable state
	- Go from A to B
	- Demo
	- --- Show that we need MANY refaster templates
		- switchIfEmpty weg. Maybe to Mono. ???? OF toch niet
- Validation
	- Two codebases
	- What percentage do we rewrite?
- Conclusion
	- **Yes** we can use EP and Refaster
	  id:: 627a447d-b424-4690-a9c4-74815a0ab2fa
	- We built a _framework_ such that you only need to write Refaster templates
-
- Feedback
	- ~~Order of names/organisations = the same as in the paper? I would assume academic org to be before the industrial org :-)~~
	- ~~You mention Refaster already on the error prone slide while it was not yet explained (even though you mentioned you did a nice two-step introduction of these tools). Can imagine this is confusing. I don't see a way to fix this however without increasing time, sorry :(~~
	- ~~The example at 5:45 the code changes between slides, before we were optimistically creating an ItemNotFoundException with the customerId but after we are deferring it and without an id. Or am I mising something?~~
	- ~~Regarding live demo, I'd increase text size or move the terminal. Roughly 40% is unused.~~
	- ~~Maybe small nitpick, but regarding migration is done around 12:00: would we not also want to rename the method back to generateKey to be fully migrated? Might be nicer to end that way :)~~
	-
	-
	- MIGRATION COMPLEXITY INDUSTRY
	-
	-
	-
	-
	- Philip Leonard16:30
	  Some things. Would be good to explain what is the diffeerence between and industrial and OSS code base in terms of migration compelxity. 
	  Philip Leonard16:33
	  In the beginning might be nice to explain what are the challenges (maybe an industry example) of large scale refactorings. Depends on the auidence, ACM peeps probably don't care that much about the industry but could be a reason to highlight to them the importance of this :D Academics in my experience don't refactor code.
	  ~~Pieter Dirk Soels16:36
	  RxJava example slide is quite a lot of text, initially, this was overwhelming. There is also some domain logic in that slide. So maybe a smaller example which you can still convey your message with (operators, methods, etc.) is nicer and people would focus more on your story than on the code.~~
	-
	-
	- More context on lib migration, current SOA
	-
	- Basically set up a framework, result bundled and shared.
	- Notes from Slack
	- rxjava -> reactor slide too long
	  explain why compilable state is important
	  ~~demo: larger text~~
	- ~~SuppressWarnings("all"). Can we avoid?~~
	  explain that method duplication is required because changes can't span more that one compilation unit
	  double conversion "don't need it" -> identity operation
	  "method defined in an interface" -> be declared by a supertype
	  "only need refaster knowledge" -> let's phrase more sharply
	- My own notes after Stephan explained his points: 
	  ```
	  hooked into the compiler, game over if it doesn't compile. 
	  during demo; presentation mode;
	  remove suppresswarnings all
	  Refaster EP can only operate within the span of 1 compilation unit. Extra methods.  So therefore need for extra steps.
	  identity conversion
	  method defined by supertype, or abstract class
	  no compiler knowledge or AST knowledge, dont need to know much more than regular java.
	  
	  maven amount of usages 
	   ```
	-
-
-
- # Conference presentation feedback Clemens
- Background is something on the wall.
- Beginning, affiliations.  Shortly mention that they are from Picnic, Amsterdam based company, and Uva.
- Not talk about what I'm going to talk about.
- More bullet points. For Error Prone. 3 bullet points for example.
-
- Demo, font is too small. Please bigger.
-
- ~~2 code bases
  150.000 lines of code
  Platform
  API Management platform~~
-
- With the exisiting set of features. But; the way you say it, existing set of features of EP and Refaster.
-
- Make it promiment, that we extend.
-
- ~~Put in slide open source.~~
- e
- ~~Slide, interface. 11.50 seconds, we have two 2 / 3 problems. SLIDE.~~
-
- ~~As I suggest, on the demo slide. Explain two parts of migration.~~
-
- ~~Validation, you talk about industrial codebase. Briefly explain, at least a few words about where they are from. 1 sentence both. Size of codebases. Slides. text.~~
-
- ~~More promoinent, bigger, the vs.~~
-
- Towards the end, have conclusion and FW. Both good, also have contributions. Stress have already done this. And add what contributed. Contributed. It is very applied. FW is last thing for sure.