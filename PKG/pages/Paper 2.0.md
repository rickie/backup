title:: Paper 2.0

-
- ### Calculation:
- Originally, everything copied over to the new format results in:
	- 8.5 pages without references (so comes till the 9th page halfway)
	- 9.5 pages with references (so there are max 10 pages)
- This translates to:
	- 11,05 pages. So with references likely 13.
-
-
- Doesn't support backpressure! RxJava.
-
- Paper 1.0: https://dl.acm.org/doi/10.1145/3477314.3507153
-
- ## What to add in the paper?
- Mockito stuff. `InlineMockitoStatements`
- Extensions to the `InlineMe`?
- Multiple return statements.
-
- ## Possible extensions
- Parameters
- Local variables?
- Variable already used fixen.
- Abstract classes fixen?
- More templates >>> is a given.
-
- ## New project
- Migration from TestNG -> JUnit
	- Is very different...
	- Can't really re-use things
-
- ## Reactor guys
- Had contact with Reactor guys.
	- They are interested.
-
- # Answers
- First copy over.
- No additional research; add more examples; more motiviation.
- Write more about the work you have done.
- Extendend version;
	- Future work can but not possible;
	- Double size.
- Reviewers like to see what is new.
-
-
- InlineMe part is not there.
- Interfaces also not.
-
- # Meeting 22-6-2022
- ~~% XXX: Should I add this? --> Talk about `Extended abstract` part? Can't find a good example for that.~~
	- Leave out
	-
- ~~What are the guidelines for new titles? Any ideas?~~
	- Titles;
-
- ~~Mag de abstract langer zijn? Of dat nog steeds niet?!~~
	- It's allowed.
	-
- I need a Author(s)' bio and photo. From both of you.
- 1.5 x 1.5 inches in size? In Word format. Create a biography of 140 words.
-
- Is it OK to make the link of the copy right an URL ? Otherwise it's a bit lame... (in copyright stuff)
-
- Do we want to mention existing tools?  In the Related work section? (There is quite some extra stuff we didn't mention in the paper, but it is already quite a big part of the paper???)
	- Batch Changes
	- OpenRewrite
		- A: We have to!!!! `OpenRewrite` is gaining traction.
		- Extra:
	-
	- ~~Other would be `Refactoring in IDEs`?~~
		- More material, easy way.
		-
- Unwrap unnecessary conversions.  --> Stephan, would it be nice to open source this in my thesis repo and?  Or give an update and tell about the `iDentityConversion` check?
	- Ofcourse; lets see if possible. But where possible, let's show it.
	- Otherwise, explain that we _want_ to do this. Intention.
	-
- ~~At the time of writing, Java 8 is niet meer ondersteunt toch? @Stephan~~
-
- ~~Do we want this? Table 3.1: The mapping of the primary RxJava types to the primary Reactor types~~
	- Yes
-
-
- When we talk about extending Refaster, do we want to link to some PRs that we opened? Or not really?
-
- More emphasis on the fact that we made a framework instead of a simple EP plugin?
	-
-
- # ADDING STUFFFF
- InlineMe stuff is not as clear
	- Show when this was added
	- Explain what limitations are lifted.
- Interfaces is not mentioned at all with examples.
- The tests are not mentioned.
-
-
-
- Inlining part is nottt at all clear. Dive into 4.1, as it is sooo important _and_ interesting.
-
- ## MEETING
- Add more stuff of many places. Things you already have, why not.
- Have meeting for the Tuesday
-
- ## Questions
- Should the part about migrating as much tests as possible be Okay to leave in or not?
	- As it can hurt validity? Or should we mention it in threads to validity.
	-
- Mention abstractions make it hard to rewrite tests.
-
-
-
-
-
- ### Copied threats to validity
- 4.3 Threats to Validity
  The validation on a single case study can be considered as
  the major internal threat to validity. Nonetheless it was
  incrementally built by numerous meetings with different domain experts of the automotive systems company. We gathered specification and feedback from several applications and
  platforms case studies, and we finally chose the presented
  one as the most representative among them.
  As for external threats, we identified the data sets as the
  main issue. While the data sets are large, they are still
  simulated. Our creation procedure has been built to mimic
  the structure and behavior of both the platforms and the
  applications, taking the real case studies as a basis to be
  expanded by generators. Still we do not have empirical evidence of their correspondence.
-
-
-
- # 7 December meeting with Clemens.
-
- What are the action points.
	- I need to ask them for some data.
	-
- It reads very nicely. The heart of the paper reads nice.
-
- Reviewer could say:
	- Don't really add new stuff. Just didn't write about.
-
-
- SourceCode Listing. Technical content from the thesis.
- More examples.
-
- DONE Add things like: 4.14 and 4.17.
-
- ## Feedback
- ~~We propose is a bit hard to understand. What is the paper about.~~
- ~~We propose to use EP and Refaster and created....~~
- ~~Second part hard to read of abstract. s/private/proprieratry/.~~
- ~~We have two use cases actually. Leave it as is. Now remember: we consider suitability. Tools as they are everyone thinks. We want to improve tools only later on. That is unmotivated. So asy~~:
	- ~~we consider bla bla. Provide numbers for vanilla. Therefore we want to create extensions. With those extensions we got further.~~ <-- heb een poging gedaan!
-
- ~~Make all Listings Times new Roman; TT tilla type.~~
-
- ~~The vague part. With the TODO, drop it.~~
-
- ~~Listing 6 check if there is a dot at the end other sentence.~~
-
- ~~4.1.2. simple operation, since~~
	- ~~make it fullstop.~~
-
- ~~Explain duplication.~~
- ~~~~So look refer at the process of dupl dele depre.~~
-
-
- ~~many ADDITIOTNAL callers safely.~~
-
- ~~lots of frameworks and lots of setups. Therefore it is challenging and~~
- ~~test code migration coverage.~~
-
- ~~Method reference usage is not really a sentence the "Convert simple...."~~
-
- ~~Not clear why it's not a bullet point .~~
-
-
-
- ~~Experimental setup instead of Validation.~~
- ~~Move 5.4.1 and add this at the end of 5.2. Reuse the one sentence on top of that.~~
-
- ~~5.4.2 goes to 5.3.~~
-
- ~~5.7 Limitations? Make it section 6. Turn the rest into subsections. 6.1 and 6.2~~
-
- ~~Experimental or just datacollection (before 6)~~
-
- ~~This section we look at various kinds of related work.~~
-
-
- ~~7. OUR extensions (what he means with which.)~~
  ~~Remove 8.~~
-
- ~~Go over bibl.~~
-
- ~~Refs checken, vooral van tabellen.~~
- ~~Dingen  toevoegen.~~
-
-
- # Bespreken volgende keer:
- **Submission II – Author(s)’ Bio and Photo**
  A biography (maximum of 140 words) along with a photo (1.5 x 1.5 inches in size) of each author must be compiled and submitted in Word format. There is no special format you need to follow; we will create your biography page for you..
-
- Hey Clemens and Stephan
-
-
-
- ## Feedback via email 23-01-23
- ~~Perhaps, it's just my printing, but the hyperlinks and the syntax highlighting seem to have vanished. Any reasons for that? I liked them.~~
- ~~The font size of all code examples could be reduced by one level. The tt font family is known to appear larger than regular text of the nominally same size.~~
- ~~Always avoid page (or column) breaks in listings. You can easily achieve this by embedding the lstlisting environment in a figure environment.~~
- ~~p1, col 1:~~
  ~~"we want to create" -> "we create" (one may *want* many things....)~~
  ~~"former code base" and "latter code base" are unclear by this point.
  Better spell them out as in the beginning of the paragraph.~~
- ~~p7, col 1:~~
  ~~"we heavily modified", "we created": always stick to present tense~~
  ~~"To give some extra context...": Explain Listing 14 in a sentence or two. Otherwise, it remains opaque what the listing is supposed to illustrate.~~
- ~~Section 5:~~
  ~~I remember we discussed the title and subsection structure of this section on zoom last time, but 
   unfortunately I didn't take exact notes. Anyhow, what's there now is not what I (presumably) had in  mind. ;-)~~
- ~~For the section title, I still suggest "Validation", like in the previous version.~~
- ~~For subsection 5.1, I would suggest "Experimental setup".~~
- ~~The section titles for 5.2, 5.3 and 5.3.1, and likewise 5.4, 5.5 and 5.5.1 do not make much sense as hey are I'm afraid.~~
- ~~My suggestion here is to combine all three 5.2, 5.3 and 5.3.1 in a single subsection without  ubsubsection and name it "Case study on industrial codebase". Same with 5.4, 5.5 and 5.5.1: "Case udy on open source code base". This doesn't even require any rewriting, just removing headlines~~
- ~~I further suggest to add one or two more sentences on Picnic. The text as is rather understates Picnic. Don't forget that no-one outside Amsterdam or perhaps the Netherlands has ever heard of Picnic, including any potential reviewer. The message we want to convey here is that Picnic is a high-tech company of serious size and standing. Perhaps, you could mention the number of employees, turn-over, international expansion, you name it. The more relevant we make Picnic, the more relevant is our work. ;-) Of course, you shouldn't overstate either, but the current text doesn't make clear whether we talk about a 5-person startup or the real Picnic.~~
- ~~Caption Listing 15: badly laid out because LaTeX isn't smart enough to hyphenatenline MockitoStatements. Surprisingly the word is not in the hyphenation data base. ;-) You could help aTeX by writing Inline\-Mockito\-Statements.~~
- ~~p10, col2:~~
  ~~"we discuss the possible limitations" -> "we discuss potential limitations"~~
- ~~Section 8:~~
  ~~Perhaps rename to "Conclusions and future work"~~
- ~~p 12, col 2:~~
  ~~"For the industrial codebase":  rather mention Picnic explicitly at his
  point of the story.~~
- ~~p 14, col 1:~~
  ~~"...  our proposed extensions" -> "...  our proposed extensions of
  Refaster and Error Prone"~~
- ~~Bibliograohy items [1] and [11] are still incomplete.~~
- ~~MAKE A TAG !!!~~
-