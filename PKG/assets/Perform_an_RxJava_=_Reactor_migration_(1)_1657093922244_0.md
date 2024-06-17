## Unexpected dependency resolution for the `annotationProcessorPaths` when using Maven profiles.

A related ticket is [MCOMPILER-272](https://issues.apache.org/jira/browse/MCOMPILER-272).

In our setup we use `annotationProcessorPaths` for libraries like [AutoService](https://github.com/google/auto/tree/master/service), [Immutables](https://immutables.github.io/), and [Error Prone](https://errorprone.info/). 
This is configured based on Maven profiles. We encountered some unexpected results w.r.t. the dependency resolution for dependencies defined in `annotationProcessorPath`s spread over different profiles. 

### The situation
In the main build, we configure the `maven-compiler-plugin` with this configuration:
```
<annotationProcessorPaths>
    <path>
        <groupId>com.google.auto.service</groupId>
        <artifactId>auto-service</artifactId>
        <version>1.0</version>
    </path>
</annotationProcessorPaths>
```

Furthermore, we have a profile `guava` which only adds the following `maven-compiler-plugin` configuration:
```
<annotationProcessorPaths combine.children="append">
    <path>
        <groupId>com.google.guava</groupId>
        <artifactId>guava</artifactId>
        <version>31.0.1-jre</version>
    </path>
</annotationProcessorPaths>
```

Note that `com.google.auto.service:auto-service` 1.0 uses Guava `30.1.1-jre`. 

## The problem
When we run `mvn clean install -Pguava -X`, we look for the part where the dependency resolution of the `annotationProcessorPath` happens, this can be found by looking for `-processorpath`.
To get the relevant output (and make it readable), one can use this command: 
`mvn clean install -Pguava -X | grep -oP '\-processorpath \S+' | xargs -d: -l1`

With `maven-compiler-plugin` versions 3.9.0+ this command will show the following output:

> -processorpath /home/rick/.m2/repository/com/google/auto/service/auto-service/1.0/auto-service-1.0.jar
/home/rick/.m2/repository/com/google/auto/service/auto-service-annotations/1.0/auto-service-annotations-1.0.jar
/home/rick/.m2/repository/com/google/auto/auto-common/1.0/auto-common-1.0.jar
/home/rick/.m2/repository/com/google/guava/guava/30.1.1-jre/guava-30.1.1-jre.jar
/home/rick/.m2/repository/com/google/guava/failureaccess/1.0.1/failureaccess-1.0.1.jar
/home/rick/.m2/repository/com/google/guava/listenablefuture/9999.0-empty-to-avoid-conflict-with-guava/listenablefuture-9999.0-empty-to-avoid-conflict-with-guava.jar
/home/rick/.m2/repository/com/google/code/findbugs/jsr305/3.0.2/jsr305-3.0.2.jar
/home/rick/.m2/repository/org/checkerframework/checker-qual/3.8.0/checker-qual-3.8.0.jar
/home/rick/.m2/repository/com/google/errorprone/error_prone_annotations/2.5.1/error_prone_annotations-2.5.1.jar
/home/rick/.m2/repository/com/google/j2objc/j2objc-annotations/1.3/j2objc-annotations-1.3.jar
/home/rick/.m2/repository/com/google/guava/guava/31.0.1-jre/guava-31.0.1-jre.jar
/home/rick/.m2/repository/org/checkerframework/checker-qual/3.12.0/checker-qual-3.12.0.jar
/home/rick/.m2/repository/com/google/errorprone/error_prone_annotations/2.7.1/error_prone_annotations-2.7.1.jar

With `maven-compiler-plugin` versions 3.8.1 and lower, we see this as output: 

> -processorpath /home/rick/.m2/repository/com/google/auto/service/auto-service/1.0/auto-service-1.0.jar
/home/rick/.m2/repository/com/google/guava/guava/31.0.1-jre/guava-31.0.1-jre.jar
/home/rick/.m2/repository/com/google/guava/failureaccess/1.0.1/failureaccess-1.0.1.jar
/home/rick/.m2/repository/com/google/guava/listenablefuture/9999.0-empty-to-avoid-conflict-with-guava/listenablefuture-9999.0-empty-to-avoid-conflict-with-guava.jar
/home/rick/.m2/repository/com/google/code/findbugs/jsr305/3.0.2/jsr305-3.0.2.jar
/home/rick/.m2/repository/org/checkerframework/checker-qual/3.12.0/checker-qual-3.12.0.jar
/home/rick/.m2/repository/com/google/errorprone/error_prone_annotations/2.7.1/error_prone_annotations-2.7.1.jar
/home/rick/.m2/repository/com/google/j2objc/j2objc-annotations/1.3/j2objc-annotations-1.3.jar
/home/rick/.m2/repository/com/google/auto/service/auto-service-annotations/1.0/auto-service-annotations-1.0.jar
/home/rick/.m2/repository/com/google/auto/auto-common/1.0/auto-common-1.0.jar

We observe a few things:
- This difference occurs after version 3.8.1 and is directly related to [MCOMPILER-272](https://issues.apache.org/jira/browse/MCOMPILER-272).
- In the current situation we have a few duplicated dependencies (with different versions however). See the dependency versions for `guava`, `checker-qual`, and `error_prone_annotations`.
- After the dependency resolution of the `annotationProcessorPath` there are 13 dependencies listed instead of 9 in the "old" situation.

This means that Maven will first see the older versions of (transitive) dependencies on the classpath and picks those over the ones specifically defined as depenency in the pom. In the example, we first encounter `guava/30.1.1-jre` while we define `guava/31.0.1-jre` in the `pom.xml`. 

---
We would like your input on this issue.
[Here](https://github.com/rickie/maven-compiler-plugin-issue-reproduction) is an example project on GitHub containing a minimal reproduction case.
For us, this problem leads to undesired and unexpected results. 
We are open to feedback and willing to propose a PR.


