#!/usr/bin/env bash

echo "::endgroup::"
echo -n "::group::Coq version "
git log -1 --pretty=oneline
git log -1
echo "::endgroup::"

echo -n "::group::Build for Coq version "
git log -1 --pretty=oneline

function end() {
    echo "::endgroup::"
    echo -n "::group::Build Result and bisect info ($1) for Coq version "
    git log -1 --pretty=oneline
    echo "Result: $2"
}

git clean -qxfd || { end 'invalid clean' $?; exit 125; }
./configure -local || { end 'invalid configure' $?; exit 125; }
make -j${NJOBS} --no-print-directory --output-sync TIMED=1 || { end bad $?; exit 1; }
end good 0
exit 0

# git bisect start bad good
# git bisect start 3c0ba7afdf 18aa9ca60e && git bisect run %cd%/coq-build.sh
