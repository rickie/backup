#!/usr/bin/bash

set -e -u -o pipefail;

ticketnumber="PSM-1187"

part=1;
iteration=1;

echo "The migration is starting:"
#################  FIRST PART OF MIGRATION ############################
# Migrate all RxJava usages to the Reactor equivalent and introduce `RxJava2Adapter` usages.
function run_migration_part_1 {
  echo "############## Call patch, part $1, iteration $2 ##############"
  mvn -T1C -Perror-prone -Ppatch clean test-compile -Derror-prone.patch-args='-XepDisableAllChecks -Xep:CheckedExceptionNotThrown:ERROR -Xep:UnnecessarilyFullyQualified:ERROR -Xep:IdentityConversion:ERROR -Xep:UnnecessaryMethodReference:ERROR -XepPatchChecks:Refaster -XepPatchLocation:IN_PLACE -XepOpt:Refaster:NamePattern=.*ToReactor.*' -DskipTests -Dverification.skip;
  mvn fmt:format
}
run_migration_part_1 $part $iteration

while [ $(git status --porcelain | wc -l) -ne '1' ]
do
  git add '*.java'
  git commit -m "$ticketnumber P$part Run $iteration"
  ((iteration=iteration+1))
  run_migration_part_1 $part $iteration
done

echo "Part 1 is done."
#################  SECOND PART OF MIGRATION ############################
# 1. Duplicate RxJava methods and "migrate" them to Reactor.
# 2.
((part=2))
((iteration=1))

echo "Start part 2."
function run_migration_part_2 {
  echo "############## Call patch, part $1, iteration $2 ##############"
  mvn -T1C -Perror-prone -Ppatch clean test-compile -Derror-prone.patch-args='-XepDisableAllChecks -Xep:CheckedExceptionNotThrown:ERROR -Xep:UnnecessarilyFullyQualified:ERROR -Xep:IdentityConversion:ERROR -Xep:UnnecessaryMethodReference:ERROR -Xep:InlineMeInliner:ERROR -Xep:InlineMeSuggester:ERROR -Xep:InlineMockitoStatements:ERROR -Xep:AddDefaultMethod:ERROR -XepPatchLocation:IN_PLACE' -DskipTests -Dverification.skip;
  mvn fmt:format
}
echo "First iteration of the second part."
run_migration_part_2 $part $iteration

while [ $(git status --porcelain | wc -l) -ne '1' ]
do
  git add '*.java'
  git commit -m "$ticketnumber P$part Run $iteration"
  ((iteration=iteration+1))
  run_migration_part_2 $part $iteration
done


echo "Start part 3."
##################  THIRD PART OF MIGRATION ############################
((part=3))
((iteration=1))

mvn -T1C -Perror-prone -Ppatch clean test-compile -Derror-prone.patch-args='-XepDisableAllChecks -Xep:RemoveOldMethods:ERROR -XepPatchLocation:IN_PLACE' -DskipTests -Dverification.skip;

mvn fmt:format

if [ $(git status --porcelain | wc -l) -ne '1' ]; then
  git add '*.java'
  git commit -m "$ticketnumber P$part Run $iteration"
  ((iteration=iteration+1))
fi

echo "Start part 4."
##################  FOURTH PART OF MIGRATION ############################
((part=4))
((iteration=1))

mvn -T1C -Perror-prone -Ppatch clean test-compile -Derror-prone.patch-args='-XepDisableAllChecks -Xep:MethodReferenceUsage:ERROR -XepPatchLocation:IN_PLACE' -DskipTests -Dverification.skip;
mvn fmt:format

if [ $(git status --porcelain | wc -l) -ne '1' ]; then
  git add '*.java'
  git commit -m "$ticketnumber P$part Run $iteration"
  ((iteration=iteration+1)) 
fi


echo "Start part 5."
##################  FIFTH PART OF MIGRATION ############################
# Cleanup the code.
((part=5))
((iteration=1))

function run_migration_part_5 {
  echo "############## Call patch, part $1, iteration $2 ##############"
  mvn -T1C -Perror-prone -Ppatch clean test-compile -Derror-prone.patch-args='-XepDisableAllChecks -Xep:CheckedExceptionNotThrown:ERROR -Xep:UnnecessarilyFullyQualified:ERROR -Xep:IdentityConversion:ERROR -Xep:UnnecessaryMethodReference:ERROR -XepPatchChecks:Refaster -XepPatchLocation:IN_PLACE -XepOpt:Refaster:NamePattern=.*RxJava.*' -DskipTests -Dverification.skip;
  mvn fmt:format
}
run_migration_part_5 $part $iteration

while [ $(git status --porcelain | wc -l) -ne '1' ]
do
  git add '*.java'
  git commit -m "$ticketnumber P$part Run $iteration"
  ((iteration=iteration+1))
  run_migration_part_5 $part $iteration
done
echo "End of the migration."
