#!/bin/bash

problem_list=$1
upstream_problems=$2

cat ${upstream_problems} > ${problem_list}
distrel=`lsb_release --codename --short`
host_arch="${DEB_HOST_ARCH:-$(dpkg --print-architecture)}"

grep -e ${host_arch} -e "arch-all" debian/tests/problems.csv | \
  grep -e ${distrel} -e "release-all" | \
  grep -e "openjdk-21" | \
  awk -F',|:' '{gsub(/ /, "", $2); print $2" 000000 generic-all" }' >> ${problem_list}
