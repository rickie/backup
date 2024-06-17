- Setting for Checkstyle 10.12.4
-
- ```
  $ ./integration-tests/checkstyle-10.12.4.sh --sync
  Shared build flags: 
    -Perror-prone-compile,error-prone-test-compile
    -Dassertj.version=3.24.2
    -Derror-prone.version=2.24.1
    -Derror-prone-support.version=0.14.1-SNAPSHOT
    -DadditionalSourceDirectories=${project.basedir}${file.separator}src${file.separator}it${file.separator}java,${project.basedir}${file.separator}src${file.separator}xdocs-examples${file.separator}java
    
  Error Prone patch flags: -XepExcludedPaths:(\Q${project.basedir}${file.separator}src${file.separator}\E(it|test|xdocs-examples)\Q${file.separator}resources\E|\Q${project.build.directory}${file.separator}\E).* -XepPatchLocation:IN_PLACE -XepPatchChecks:AmbiguousJsonCreator,AssertJIsNull,AssociativeMethodInvocation,AutowiredConstructor,CanonicalAnnotationSyntax,CanonicalClassNameUsage,CollectorMutability,DirectReturn,EmptyMethod,ErrorProneRuntimeClasspath,ErrorProneTestHelperSourceFormat,ExplicitEnumOrdering,FluxFlatMapUsage,FluxImplicitBlock,FormatStringConcatenation,IdentityConversion,ImmutablesSortedSetComparator,IsInstanceLambdaUsage,JUnitClassModifiers,JUnitMethodDeclaration,JUnitNullaryParameterizedTestDeclaration,JUnitValueSource,LexicographicalAnnotationAttributeListing,LexicographicalAnnotationListing,MethodReferenceUsage,MockitoMockClassReference,MockitoStubbing,MongoDBTextFilterUsage,NestedOptionals,NestedPublishers,NonEmptyMono,NonStaticImport,PrimitiveComparison,RedundantStringConversion,RefasterAnyOfUsage,RefasterMethodParameterOrder,RefasterRuleModifiers,RequestMappingAnnotation,RequestParamType,Slf4jLogStatement,SpringMvcAnnotation,StaticImport,StringJoin,TimeZoneUsage,UnqualifiedSuggestedFixImport,Refaster
  Error Prone validation flags: -XepExcludedPaths:(\Q${project.basedir}${file.separator}src${file.separator}\E(it|test|xdocs-examples)\Q${file.separator}resources\E|\Q${project.build.directory}${file.separator}\E).* -XepDisableAllChecks -Xep:AmbiguousJsonCreator:WARN -Xep:AssertJIsNull:WARN -Xep:AssociativeMethodInvocation:WARN -Xep:AutowiredConstructor:WARN -Xep:CanonicalAnnotationSyntax:WARN -Xep:CanonicalClassNameUsage:WARN -Xep:CollectorMutability:WARN -Xep:DirectReturn:WARN -Xep:EmptyMethod:WARN -Xep:ErrorProneRuntimeClasspath:WARN -Xep:ErrorProneTestHelperSourceFormat:WARN -Xep:ExplicitEnumOrdering:WARN -Xep:FluxFlatMapUsage:WARN -Xep:FluxImplicitBlock:WARN -Xep:FormatStringConcatenation:WARN -Xep:IdentityConversion:WARN -Xep:ImmutablesSortedSetComparator:WARN -Xep:IsInstanceLambdaUsage:WARN -Xep:JUnitClassModifiers:WARN -Xep:JUnitMethodDeclaration:WARN -Xep:JUnitNullaryParameterizedTestDeclaration:WARN -Xep:JUnitValueSource:WARN -Xep:LexicographicalAnnotationAttributeListing:WARN -Xep:LexicographicalAnnotationListing:WARN -Xep:MethodReferenceUsage:WARN -Xep:MockitoMockClassReference:WARN -Xep:MockitoStubbing:WARN -Xep:MongoDBTextFilterUsage:WARN -Xep:NestedOptionals:WARN -Xep:NestedPublishers:WARN -Xep:NonEmptyMono:WARN -Xep:NonStaticImport:WARN -Xep:PrimitiveComparison:WARN -Xep:RedundantStringConversion:WARN -Xep:RefasterAnyOfUsage:WARN -Xep:RefasterMethodParameterOrder:WARN -Xep:RefasterRuleModifiers:WARN -Xep:RequestMappingAnnotation:WARN -Xep:RequestParamType:WARN -Xep:Slf4jLogStatement:WARN -Xep:SpringMvcAnnotation:WARN -Xep:StaticImport:WARN -Xep:StringJoin:WARN -Xep:TimeZoneUsage:WARN -Xep:UnqualifiedSuggestedFixImport:WARN -Xep:Refaster:WARN
  ~/repos/error-prone-support/integration-tests/.repos/checkstyle ~/repos/error-prone-support
  rick.ossendrijver@gmail.com
  Rick Ossendrijver
  Removing target/
  [detached HEAD cf68a43] dependency: Introduce Error Prone Support
   10 files changed, 55 insertions(+), 3 deletions(-)
  
  ```