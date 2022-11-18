#!/bin/bash
vip=10.64.15.254

for i in 0 1; do
  ip=$(terraform output -json |jq -r .[].value[$i].ce_public_ip 2>/dev/null | head -2 | tail -1)
  echo -n ce$i $ip ...
#  verPodIp=$(ssh -o "StrictHostKeyChecking=no" core@$ip sudo kubectl -n ves-system get pod ver-0 -o json | jq -r .status.podIP)
  verPodIp=$(ssh -o "StrictHostKeyChecking=no" core@$ip sudo kubectl -n ves-system get pod ver-0 --template '{{.status.podIP}}')
  echo "ver-0 PodIP $verPodIp"
  echo -n "removing existing static route for $vip (if present) ..."
  ssh -o "StrictHostKeyChecking=no" core@$ip sudo ip route del $vip
  echo -n " adding static route to vip ..."
  ssh -o "StrictHostKeyChecking=no" core@$ip sudo ip route add $vip via $verPodIp
  echo ""
done
