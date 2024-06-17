- `(\/\*\*\n)(\s*)\*(.*)\n(\s*)\*\n`
-
-
- 15 minuten in de ochtend van 7 feb.
- 13.03 - 13.23
-
- 14.20 - 15.05 15.30 - 16.20
-
- 09.10 - 10.45 + 30 min 30 min.
-
- `(\/\*\*\n)(\s*)\*.*[^.]$(\s*)\*\n`
-
-
-
- ```
  git ls-files '*.java' | xargs perl -0777 -pi -e 's/(\/\*\*\n)(\s*)\*(.*[^.:])\n(\s*)\*\n/ \1 \2 \3\.\n \4/g'
  git ls-files '*.java' | xargs perl -0777 -pi -e 's/(\/\*\*)((?:\s*\*(?:.+[^.:]))*)(\n\s*\*[\n|\/])/\1\2\.\3/gm'
  mvn fmt:format
  git ls-files '*.java' | xargs perl -0777 -pi -e 's/\{\@inheritDoc\}\./\{\@inheritDoc\}/g'
  git ls-files '*.java' | xargs perl -0777 -pi -e 's/(\/\*\* .*)([^.])( \*\/)\n/\1\2\. \3\n/g'
  mvn fmt:format
  ```
- `git ls-files '*.java' | xargs perl -0777 -pi -e 's/(\/\*\*\n)(\s*)\*(.*[^.:])\n(\s*)\*\n/ \1 \2 \3\.\n \4/g'`
- `mvn format:fmt`
- `git ls-files '*.java' | xargs perl -0777 -pi -e 's/\{\@inheritDoc\}\./\{\@inheritDoc\}/g'`
- `git ls-files '*.java' | xargs perl -0777 -pi -e 's/(\/\*\* .*)([^.])( \*\/)\n/\1\2\. \3\n/g'`
- `mvn fmt:format`
-
- `git ls-files '*.java' | xargs perl -0777 -pi -e 's/(\/\*\*)((?:\s*\*(?:.+[^.:]))*)(\n\s*\*[\n|\/])/\1\2\.\3/gm'`
-
-
-
-
- ```
  // DE PROD
  Verifying whether the following queue can be migrated: de prod FC2.pom.rejections.
  2022-12-12 15:08:26,942 picnic.quorum_migration.cli cli ERROR Corresponding dead letter queue is not empty.
  Verifying whether the following queue can be migrated: de prod FC0.wms.asn.
  2022-12-12 15:17:47,220 picnic.quorum_migration.cli cli ERROR Corresponding dead letter queue is not empty.
  Verifying whether the following queue can be migrated: de prod FC2.wms.asn.
  2022-12-12 15:18:27,922 picnic.quorum_migration.cli cli ERROR Corresponding dead letter queue is not empty.
  Verifying whether the following queue can be migrated: de prod wms-insight.pick-round.
  2022-12-12 15:19:30,766 picnic.quorum_migration.cli cli INFO Queue `wms-insight.pick-round` can be migrated.
  
  // FR PROD
  
  
  // NL PROD
  
  ```
-
-
-
- ```
  package tech.picnic.errorprone.plugin;
  
  import static com.google.errorprone.BugPattern.SeverityLevel.ERROR;
  import static com.google.errorprone.BugPattern.SeverityLevel.SUGGESTION;
  import static org.assertj.core.api.Assertions.assertThat;
  
  import com.google.errorprone.BugPattern;
  import com.google.errorprone.CompilationTestHelper;
  import com.google.errorprone.VisitorState;
  import com.google.errorprone.bugpatterns.BugChecker;
  import com.google.errorprone.bugpatterns.BugChecker.ClassTreeMatcher;
  import com.google.errorprone.matchers.Description;
  import com.sun.source.tree.ClassTree;
  import com.sun.source.util.TaskEvent;
  import com.sun.source.util.TaskEvent.Kind;
  import org.junit.jupiter.api.Test;
  import tech.picnic.errorprone.plugin.models.BugPatternData;
  
  final class BugPatternExtractorTest {
    @Test
    void create() {
      CompilationTestHelper.newInstance(ExtractBugPatternDataTestChecker.class, getClass())
          .addSourceLines(
              "pkg/TestChecker.java",
              "package pkg;",
              "",
              "import com.google.errorprone.BugPattern;",
              "import com.google.errorprone.BugPattern.SeverityLevel;",
              "import com.google.errorprone.bugpatterns.BugChecker;",
              "",
              "@BugPattern(",
              "    name = \"OtherName\",",
              "    summary = \"Example summary\",",
              "    linkType = BugPattern.LinkType.CUSTOM,",
              "    link = \"https://error-prone.picnic.tech\",",
              "    explanation = \"Example explanation\",",
              "    severity = SeverityLevel.SUGGESTION,",
              "    altNames = \"Check\",",
              "    tags = BugPattern.StandardTags.SIMPLIFICATION)",
              "public final class TestChecker extends BugChecker {}")
          .doTest();
    }
  
    /** A {@link BugChecker} that validates the {@link BugPatternExtractor}. */
    @BugPattern(summary = "Validates `BugPatternExtractor` output", severity = ERROR)
    public static final class ExtractBugPatternDataTestChecker extends BugChecker
        implements ClassTreeMatcher {
      private static final long serialVersionUID = 1L;
  
      @Override
      public Description matchClass(ClassTree tree, VisitorState state) {
        TaskEvent event = new TaskEvent(Kind.ANALYZE);
        BugPatternData bugPatternData = new BugPatternExtractor().extractData(tree, event, state);
  
        assertThat(bugPatternData.fullyQualifiedName()).isEqualTo("pkg.TestChecker");
        assertThat(bugPatternData.name()).isEqualTo("OtherName");
        assertThat(bugPatternData.altNames()).containsOnly("Check");
        assertThat(bugPatternData.link()).isEqualTo("https://error-prone.picnic.tech");
        assertThat(bugPatternData.tags()).containsExactly("Simplification");
        assertThat(bugPatternData.summary()).isEqualTo("Example summary");
        assertThat(bugPatternData.explanation()).isEqualTo("Example explanation");
        assertThat(bugPatternData.severityLevel()).isEqualTo(SUGGESTION);
        assertThat(bugPatternData.disableable()).isTrue();
  
        return Description.NO_MATCH;
      }
    }
  }
  
  ```
-
-
- ```
   @Test
    void noOutputForWrongTaskEventKind(@TempDir Path directory) {
      Path outputPath = directory.resolve("pkg").toAbsolutePath();
  
      JavaFileObject javaFileObject =
          FileObjects.forSourceLines(
              "A.java",
                  "MinimalTestChecker.java",
                  "package pkg;",
                  "",
                  "import com.google.errorprone.BugPattern;",
                  "import com.google.errorprone.BugPattern.SeverityLevel;",
                  "import com.google.errorprone.bugpatterns.BugChecker;",
                  "",
                  "@BugPattern(summary = \"Example summary\", severity = BugPattern.SeverityLevel.ERROR)",
                  "public final class MinimalTestChecker extends BugChecker {}");
  
      JavaCompiler compiler = JavacTool.create();
      JavacTaskImpl task =
          (JavacTaskImpl)
              compiler.getTask(
                  null,
                  null,
                  null,
                  ImmutableList.of(
                      "-Xplugin:DocumentationGenerator -XdocsOutputDirectory=" + outputPath),
                  ImmutableList.of(),
                  ImmutableList.of(javaFileObject));
  
      task.parse();
  
      //    compile(
      //        outputPath.toString(),
      //        "TestChecker.java",
      //        Kind.GENERATE,
      //        "package pkg;",
      //        "",
      //        "import com.google.errorprone.BugPattern;",
      //        "import com.google.errorprone.BugPattern.SeverityLevel;",
      //        "import com.google.errorprone.bugpatterns.BugChecker;",
      //        "",
      //        "@BugPattern(",
      //        "    name = \"OtherName\",",
      //        "    summary = \"Example summary\",",
      //        "    linkType = BugPattern.LinkType.CUSTOM,",
      //        "    link = \"https://error-prone.picnic.tech\",",
      //        "    explanation = \"Example explanation\",",
      //        "    severity = SeverityLevel.SUGGESTION,",
      //        "    altNames = \"Check\",",
      //        "    tags = BugPattern.StandardTags.SIMPLIFICATION,",
      //        "    disableable = false)",
      //        "public final class TestChecker extends BugChecker {}");
  
      Path docsPath = outputPath.resolve("docs").toAbsolutePath();
      assertThat(docsPath).isEmptyDirectory();
    }
  
  ```
-
-