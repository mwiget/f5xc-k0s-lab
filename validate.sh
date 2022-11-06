#!/bin/bash
for i in 0 1; do
  echo -n "$(date) ce$i ... "
  ./ssh-ce-$i.sh curl -s -H Host:workload.site1 10.64.15.254 | grep Hello
  echo -n "$(date) wl$i ... "
  ./ssh-wl-$i.sh curl -s -H Host:workload.site1 10.64.15.254 | grep Hello
done
