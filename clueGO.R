library("CompGO")
library("pathview")
library('org.Mm.eg.db')



setwd("/data3/arubio/projects/Andrea_CircaN_rebuttal/reports/bio_data/hidalgo/files/")

# depsA <- read.delim("circan_circa_genes_clusters.csv", header=T, sep=",", stringsAsFactors = FALSE)
depsA <- read.csv("circan_circa_genes_clusters.csv", stringsAsFactors = F, row.names = 1)
# depsB <- read.delim("metacycle_circa_genes_clusters.csv", header=T, sep=",", stringsAsFactors = FALSE)
depsB <- read.csv("metacycle_circa_genes_clusters.csv", stringsAsFactors = F, row.names = 1)


depsA$entrez <- mapIds(org.Mm.eg.db, depsA[,1], 'ENTREZID', 'ENSEMBL')
depsB$entrez <- mapIds(org.Mm.eg.db, depsB[,1], 'ENTREZID', 'ENSEMBL')

davidA <- DAVIDWebService(email="jmadrover@cnic.es", url="https://david.ncifcrf.gov/webservice/services/DAVIDWebService.DAVIDWebServiceHttpSoap12Endpoint/")
FnAnotA <- getFnAnot_genome(depsA$Row.names, email="jmadrover@cnic.es", david=davidA, idType="ENSEMBL_GENE_ID", getKEGG = F)

davidB <- DAVIDWebService(email="jmadrover@cnic.es", url="https://david.ncifcrf.gov/webservice/services/DAVIDWebService.DAVIDWebServiceHttpSoap12Endpoint/")
FnAnotB <- getFnAnot_genome(depsB$Row.names, email="jmadrover@cnic.es", david=davidB, idType="ENSEMBL_GENE_ID", getKEGG = F)

Zcomparison <- compareZscores(FnAnotA, FnAnotB, geneInfo = T)
write.csv(Zcomparison, "circaN_mc_comp_GOZscores.csv")

Zcomparisonsignig <- Zcomparison[which(Zcomparison$Pvalue < 0.05),]
# pdf("circaN_mc_comp_GOZscores.pdf", width=17, height=12)
ggplot(Zcomparisonsignig, aes(x=ComparedZ, y=Term, size = 10, color=Pvalue)) +
      geom_point(alpha=0.4) +
      scale_size_continuous(range=c(1,10)) +
      xlab("Compared Z") + ylab("Term") +
      # labs(title = "Compared Z scores of CircaN and MC, pvalue<0.05") +
      theme_bw()

# dev.off()

plotPairwise(FnAnotA, FnAnotB, ontology='BP', useRawPvals = F, plotNA = F, model = "lm")+
  
  #geom_point(alpha=0.4) +
  
  scale_size_continuous(range=c(1,10)) +
  
  xlab("-log10(CircaN)") + ylab("-log10(MC)") +
  
  labs(title = "Pairwise plot") +
  
  theme_bw()



plotTwoGODags(FnAnotA, FnAnotB, ont='BP', fullNames = TRUE, Pvalues = TRUE)



plotZRankedDAG(FnAnotA, FnAnotB, ont='BP', n=20, fullNames = TRUE)



plotZScores(FnAnotA, FnAnotB, plotNA = T, plotAbs = T, model = "lm")+
  
  #geom_point(alpha=0.4) +
  
  scale_size_continuous(range=c(1,10)) +
  
  xlab("-log10(CircaN)") + ylab("-log10(MC)") +
  
  labs(title = "Zscores plot") +
  
  theme_bw()



slidingJaccard(FnAnotA, FnAnotB, increment=10)



data("bods", package = "pathview")



keggB <- FnAnotB[which(FnAnotB$Category=='KEGG_PATHWAY'),]

keggA <- FnAnotA[which(FnAnotA$Category=='KEGG_PATHWAY'),]



viewKegg(FnAnotA, FnAnotB)



viewKegg(FnAnotA, FnAnotB, keggTerm = 'mmu00190')



FnAnotAsig <- FnAnotA[which(FnAnotA$PValue < 0.05),]

FnAnotBsig <- FnAnotB[which(FnAnotB$PValue < 0.05),]



plotPairwise(FnAnotAsig, FnAnotBsig)+
  
  #geom_point(alpha=0.4) +
  
  scale_size_continuous(range=c(1,10)) +
  
  xlab("-log10(WT)") + ylab("-log10(Depleted)") +
  
  labs(title = "WT ZT5/ZT13 proteomics: BP-GO Terms") +
  
  theme_bw()



slidingJaccard(FnAnotAsig, FnAnotBsig, increment=10)