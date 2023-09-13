library(viper)

args <- commandArgs(trailingOnly = T)

networks <- read.table(args[1],header = T)
expression <- read.csv(args[2],row.names = 1)
expression <- as.matrix(expression)

metabolite_gene2 <- read.csv(args[3],row.names = 1)
metabolite_gene2 <- metabolite_gene2$x

network_select <- networks[networks$Target %in% metabolite_gene2,-4]
network_select <- as.matrix(network_select)
write.table(network_select,"re_network.txt",row.names = F,col.names = F,quote = F,sep = "\t")
net <- "./re_network.txt"


regulon <- aracne2regulon(net,expression,format = "3col")

#calculate viper
res <- viper(expression,regulon)
write.csv(res,"protein_activate.csv")
