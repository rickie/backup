title:: TestNG -> JUnit

-
-
- # Notities oudere meeting
- Zo niet doen met checkedExceptions.
-
- Is de translatie semantisch correct.
- Haal bepaalde property's weg, wat we overhouden is soort van Frankenstein, test.
-
- TestNgClassLevel zit iets waar we in principe een matcher voor gebruiken. AUTOWIRED_ANNOTATION, multimatcher, Ik wil dat iets dat geannotateerd is met ten minste 1x autowired.
-
- Waarom zijn dit twee checks;
-
- Of ClassLevel annotation een argument heeft. Dat moet zeker dubbel gedubbelcheckt worden.
- Group=foo; TestNG alles zit in groep van top level class, inheritance.
- ClassLevel en MethodLevel check.
	- Gegeven ClassLevelMatcher, voor elke method kijk ik, heeft ie testNG annotatie, en support ik alle argumenten op die annotatie en doe ik (als er ook iets op de classlevel is), je bepaald semantiek van de test door naar annotatie, classlevel annotatie en arumgnetne te kijken.
	- public methods gaan we niet meer speciaal behandelen. je loopt erover heen
		- Is public in classlevel annoatted test
		- of @Test
	- Kan ik deze volledig migreren?
	- Als er een dataprovider is, moet ik nieuwe method introduceren en een methodsource en all that shit, excepted exception wrappen in assertthrows.
- Vervolgens; kan ik ook method zonder annotatie direct meenemen, wat betekent dit; iedere methode migreer ik in een keer, 100%. Ervanuitgaande dat alle argumenten supported zijn.
-
-
- Alle methoden die ik heb geidentificeerd; heb ik een fix ge-emit of niet; als ik alle methods heb kunnen migrerne, dan drop ik ook de classlevel annotations.
- Als ik niet alle testmethods heb gemireerd, flaggetje, of ik wel of niet alles emit.
	- ` conservative` als je helemaal zeker bent;
	- anders niet
-
- Twee parameterized tests, dan maar 1x omschrijven.
- Map naar optional fix, alleen als alles not empty is; dan emitten.
- Voor een gegeven testNG test annotatie,
- Voor elke attribute, map naar optional fix, als dat lukt, dan kun je de hele test migreren.
-
- Een van de annotaties niet herkend, wordt ie niet gemigreerd.
-
- Dat het niet in een keer kan.
- Twee annotaties, twee attributes op TestNG annotatie.
-
- Die spaties
-