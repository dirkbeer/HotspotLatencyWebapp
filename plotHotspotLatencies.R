plotHotspotLatencies <- function(){
  
  library(ssh)
  library(ggplot2)

  source("mysecrets.R")
  datafilename <- "hotspot_latency.txt"

  mytz <- Sys.timezone(location = TRUE)
  
  sesh<-ssh_connect(paste(myusername, "@", myipdaddress, sep=""), passwd=mypassword)
  scp_download(sesh, datafilename)
  ssh_disconnect(sesh)
  
  dat <- read.delim(datafilename, header=FALSE, sep="\t")
  dat$Date <- as.POSIXct(strptime(dat$V1, format="%a %d %b %Y %I:%M:%S %p", tz="UTC"))
  dat$Hotspot <- dat$V2
  dat$Latency <- as.numeric(dat$V11)
  # when port is closed, put in the maximum recorded latency
  dat$Latency[is.na(dat$Latency)] <- max(dat$Latency, na.rm = TRUE)
  dat$Service <- as.factor(dat$V8)
  dat$Status <- as.factor(dat$V5)
  
  gg <- ggplot(dat, aes(x = Date, y = Latency, color=Status)) + geom_point() +
    xlab("Time") + ylab("Latency (s)") +
    facet_wrap(~ Hotspot) +
    ylim(min(dat$Latency), max(dat$Latency))
  
  print(gg)
}
