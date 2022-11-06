 #!/bin/bash
./ssh-ce-0.sh sudo kubectl -n ves-system logs vp-manager-0 > vpm-log-mw-aws-r1-0.txt
./ssh-ce-1.sh sudo kubectl -n ves-system logs vp-manager-0 > vpm-log-mw-aws-r1-1.txt
./ssh-ce-0.sh sudo kubectl -n ves-system get node -o yaml > nodes-mw-aws-r1-0.txt
./ssh-ce-1.sh sudo kubectl -n ves-system get node -o yaml > nodes-mw-aws-r1-1.txt
./ssh-ce-0.sh sudo kubectl -n ves-system get pod -o yaml > pod-mw-aws-r1-0.txt
./ssh-ce-1.sh sudo kubectl -n ves-system get pod -o yaml > pod-mw-aws-r1-1.txt
