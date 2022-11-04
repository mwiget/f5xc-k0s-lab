#!/bin/bash
ip=$(terraform output -json |jq -r .[].value[1].ce_public_ip 2>/dev/null | head -2 | tail -1)
echo ssh core@$ip ...
ssh core@$ip $@
