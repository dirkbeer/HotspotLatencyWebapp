#!/bin/bash

# 
# Add the following line to your crontab using crontab -e:
# 
#   */10 * * * * /home/myusername/get_helium_latency.sh
#

outfilename=hotspot_latency.txt
datetime=$(date | sed 's/\n//')

function get_hotspot_data () {
        hs=("$@")
        result=$(nmap -oG /dev/stdout -Pn -n -p ${hs[2]} -sV ${hs[1]} | grep Ports | sed 's/^.*Ports: //' | sed 's/Host is up\.//' |  sed 's/Host is up (//' | sed 's/s latency)\.//' | sed 's:/:\t:g')
        printf "$datetime\t${hs[0]}\t${hs[1]}\t$result\n" >> $outfilename
}

hs=(tadpole 68.128.112.183 44158)
get_hotspot_data "${hs[@]}"

hs=(buffalo 99.171.128.180 44158)
get_hotspot_data "${hs[@]}"

hs=(beaver 128.26.117.34 44158)
get_hotspot_data "${hs[@]}"

hs=(spider 72.26.117.128 44158)
get_hotspot_data "${hs[@]}"

# keep file size reasonable by only keeping a maximum number of lines
#     e.g. 3 days * 24 hours/day * 60 minutes/hour * 1 sample / 10 minutes * 4 lines/sample = 1728
echo "$(tail -1728 $outfilename)" > $outfilename
