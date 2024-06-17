- #error-prone-support
-
- Discussing generation of the EPS website.
-
-
- RefasterRUleCompiler;
	- TaskListener;
	- Zij gebruiken een plugin. AbstractProcessor.
	- aNNOTAtionlistener?
- I
-
- In geval van BugPattern; naam etc. Extract je.
- Meta data kan je eruit trekken.
- Schrijf je weg op JSON, md.
- Vervolgens, Refaster template, herken je aan template met @BeforetTemplate methode.
- Annotatie op class niveau. Arbirtrary dieptes.
-
- Meta data extracten in de plugin en weegschrijven.
- `implements TaskListener`!!! Gebruiken.
- Minder informatie in andere.
-
- # Meta data extraction
- Output is straks 4 typen.
- Refaster en EP meta data.
- Voor beide input output.
- Met JQ geen java code nodig?
- Data converteert naar .md
-
-
- Voor de diff, diff -u 1000 /tmp[ab]
-
-
-
- Static scanners
-
-
-
-
- ```
  private static Class<?> getClass(String fqcn) {
      try {
        return RefasterIntrospection.class.getClassLoader().loadClass(fqcn);
      } catch (ClassNotFoundException e) {
        throw new IllegalStateException(String.*format*("Failed to load class `%s`", fqcn), e);
      }
    }
  }
  ```
-
- private static final Class<?> *UCLASS_IDENT *= getClass(*UCLASS_IDENT_FQCN*);
  private static final Class<?> *UCLASS_AUTOVALUE_IDENT *= getClass(*AUTO_VALUE_UCLASS_IDENT_FQCN*);