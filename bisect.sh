#!/usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

# git bisect start bad good
# git bisect start 3c0ba7afdf 18aa9ca60e && git bisect run ../coq-build.sh
# c48af75d6c60119c826c4dbfd6ede053d3ee9181 is V8.11.1
echo -n "::group::Starting bisect"
git bisect start 9de39626d925aa8ed0138fc5b90ee30ccf1ac4c1 18aa9ca60e && git bisect run "${DIR}/coq-build.sh"
echo "::endgroup::"
