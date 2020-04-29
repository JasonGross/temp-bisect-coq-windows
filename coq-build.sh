#!/usr/bin/env bash

echo -n "::group::Coq version "
git log -1 --pretty=oneline
git log -1
echo "::endgroup::"

echo -n "::group::Build for Coq version "
git log -1 --pretty=oneline

set -ex

git clean -qxfd || { echo "::endgroup::"; exit 125; }
./configure -local || { echo "::endgroup::"; exit 125; }
make -j${NJOBS} --output-sync TIMED=1 || { echo "::endgroup::"; exit 1; }

echo "::endgroup::"
exit 0

# git bisect start bad good
# git bisect start 3c0ba7afdf 18aa9ca60e && git bisect run %cd%/coq-build.sh
