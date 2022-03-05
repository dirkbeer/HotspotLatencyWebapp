plotHotspotLatencies <- function(){
  
library(ssh)
library(ggplot2)
library(scales)


datafilename <- "hotspot_latency.txt"
#start_time <- '2022-03-03 00:00:00'
label_interval = "6 hours"

mytz <- Sys.timezone(location = TRUE)

source("mysecrets.R")
sesh<-ssh_connect(paste(myusername, "@", myipdaddress, sep=""), passwd=mypassword)
scp_download(sesh, datafilename)
ssh_disconnect(sesh)

dat <- read.delim(datafilename, header=FALSE, sep="\t")
dat$Date <- as.POSIXct(strptime(dat$V1, format="%a %d %b %Y %I:%M:%S %p", tz="UTC"))
dat$Hotspot <- dat$V2
dat$Latency <- as.numeric(dat$V11)
dat$Latency[is.na(dat$Latency)] <- max(dat$Latency, na.rm = TRUE)
dat$Service <- as.factor(dat$V8)
dat$Status <- as.factor(dat$V5)

#dat <- subset(dat, Date>as.POSIXct(start_time,tz=mytz))

gg <- ggplot(dat, aes(x = Date, y = Latency, color=Status)) + geom_point() +
  scale_x_datetime(labels = date_format("%H\n%a", tz=mytz), date_breaks = label_interval) +
  xlab("Time") + ylab("Latency (s)") + ggtitle("Hotspot P2P Response Latency") +
  facet_wrap(~ Hotspot) +
  ylim(min(dat$Latency), max(dat$Latency))

print(gg)
}
