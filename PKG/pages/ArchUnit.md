- #Picnic
-
- To run ArchUnit specifically: `build -Dtest=ArchitectureTest -Dsurefire.failIfNoSpecifiedTests=false`
-
- `archRule.failOnEmptyShould = false` ?  https://github.com/PicnicSupermarket/picnic-finance-support-modules/pull/30/files#diff-a96febd94c7fb5153037823264869f6a632385dc6bbc02e8c2a8a79fb3ac9c04
-
- Command `freeze.refreeze=true` to update with new violations, see https://github.com/TNG/ArchUnit/pull/612.
-
- ```
  public final class StreamRules implements ArchUnitRuleProvider {
    public static final ArchRule NO_STREAM_AS_RETURN_TYPE =
        noMethods()
  //          .that()
  //          .areDeclaredInClassesThat()
  //          .haveSimpleNameNotEndingWith("Test")
            .should()
            .haveRawReturnType(Stream.class)
            .because("Avoid using `Stream` as return type  of a method.");
  
    @Override
    public ImmutableSet<ArchRule> getRules() {
      return ImmutableSet.of(NO_STREAM_AS_RETURN_TYPE);
    }
  }
  
  ```