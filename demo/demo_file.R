source('R/clValid-Classes.R')
source('R/clValid-functions.R')
source('R/clValid-internal.R')
source('R/clValid-Methods.R')
library(cluster)

# create dummy data
dat=data.frame(X1=sample(c(0,1),size = 1000,replace = T),
               X2=sample(c(0,1),size = 1000,replace = T),
               X3=sample(c(0,1),size = 1000,replace = T),
               X4=sample(c(0,1),size = 1000,replace = T))

# add some signal for two clusters
indx1=sample(1:1000,size = 500,replace = F)

# loop to add signal
for(i in indx1){
  set.seed(i)
  r=sample(0:1,size = 4,replace = T)
  dat[i,]=dat[i,]*r
}

# second loop to add signal
for(i in setdiff(1:1000,indx1)){
  set.seed(i)
  r=sample(0:1,size = 4,replace = T)
  dat[i,]=dat[i,]*r
}


# run clustering
cl=clValid(obj = dat,nClust = 2:8,clMethods = "clara",validation = c("internal","stability"),
           maxitems = 1000,metric = "manhattan",samples=20,sampsize=100)
factoextra::fviz_nbclust(x = dat,FUNcluster = cluster::clara)
fviz_nb
# get measures
cl@stabObjs$clara
cl@measures[,,1]
