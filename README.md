# A pipeline for calculating enzyme activity using your own network

This pipeline is for constructed your own comprehensive network, and calculated the enzyme activity. 

We have finish the TCGA 33 cancers metabolic network, you can calculated the specific tumor metabolic enzyme activity, please click  **[TCGAnetworks]**

### Install the require packages:
- igraph
- RANKS
- viper


## step 1: Add your own network to our comprehensive networks.
#### Input network file format
A CSV file with two columns: the first column contains start genes, and the second column contains target genes. e.g.
   
           start      target
    1     Caffeine    CYP1A2
    2   Paraxanthine  CYP1A2
    3       ARF5       RAB36

then, execute:

    Rscript  ./RWRnetwork/RWR_filter_network.R yournetwork

#### Output file will be a genelist with RWR restart value 0.7 and top 80% affinity score genes.

## step 2: Constructed your ARACNE networks.
We recommend using ARACNe-AP for inferring and constructing your own network.

**[ARACNe-AP](https://github.com/califano-lab/ARACNe-AP)**

## setp 3: Calculate the enzyme activity
#### Input file:
- Gene expression csv file, with gene SYMBOL name in rownames and sample name in colnumes
- Aracne output network file
- Step1 output genes list

then, execute:

    Rscript ./CalActivity/Cal_EnzymeActivity.R networkfile genelistfile

#### Output file:
- ***re_network.txt***  the filtered networks used for calculate the enzyme activity
- ***protein_activity.csv*** the sample enzyme activity file.

