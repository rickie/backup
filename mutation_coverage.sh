#!/usr/bin/env bash

set -euo pipefail

targetTests=${1:-*}

mvn clean test pitest:mutationCoverage -Dverification.skip -DfailIfNoTests=false -Dtest="${targetTests}" -DtargetTests="${targetTests}"
