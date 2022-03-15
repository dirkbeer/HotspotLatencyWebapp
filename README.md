# HotspotLatencyWebapp

Measure your hotspot's response latency by running a simple bash script using cron in Linux. 
* Ideally installed on a machine not on the hotspot's networks, like a Linode VPS 
* Requires the nmap utility, which you can install using, for example, `sudo apt update && sudo install nmap` on Debian or Ubuntu
* Copy `get_helium_latency.sh` to your user folder, for example, to `/home/myusername`
* Edit that file with your hotspot name(s) and ip address(es) using, for example, `nano /home/myusername/get_helium_latency.sh`
* Make the file executable: `chmod +x /home/myusername/get_helium_latency.sh`
* Add the following line to your crontab using `crontab -e`: `*/10 * * * * /home/myusername/get_helium_latency.sh`
* Download the resulting tab-delimited file called `hotspot_latency.txt`, and plot using Excel or whatever method you prefer.

The R scripts provided download the file using scp, plot the latencies using ggplot2, and display them as an R Shiny webapp in your local browser. The webapp can also be published to shinyapps.io (free) so that it can be accessed from anywhere. 


![Webapp](https://github.com/dirkbeer/HotspotLatencyWebapp/blob/main/webappscreencap.png)


