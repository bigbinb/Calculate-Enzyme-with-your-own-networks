library(RANKS)
library(igraph)

args <- commandArgs(trailingOnly = T)

netadd <- read.csv(args[1],row.names = 1)
netcells <- read.csv("./Comprehensive_networks.csv",row.names = 1)
colnames(netadd) <- colnames(netcells)
print("Merge the network...")
merge_network <- rbind(netadd, netcells)
metabolites <- read.csv("./Metabolites.csv")
metabolites <- metabolites$x

##covert to igraph network
print("Invert to igraph object...")
igraph_network <- graph_from_data_frame(merge_network,directed = T)
ADJ = as_adjacency_matrix(igraph_network)
print("Calculate the affinity score..")
AffM=RWR(ADJ%>%as.matrix(), metabolites, gamma = 0.6, tmax = 1000, eps = 1e-10, norm = TRUE)

affscore <- AffM$p %>% as.data.frame()
affscore$genes <- rownames(affscore)

select_genes <- affscore[affscore$. > quantile(affscore$.,0.2),]
select_genes <- select_genes$genes
write.csv(select_genes,"RWR_filtered_genes.csv")

