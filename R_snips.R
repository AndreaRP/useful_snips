###################### capitalize first letter ##########################
tools::toTitleCase()


###################### Convert gene aliases to official symbol ##########################
chemokines <- limma::alias2Symbol(tools::toTitleCase(tolower(chemokines_file$Chemokine)), species="Mm")


###################### Simulate gene expression counts counts ##########################
#' @param G number of groups
#' @param N number of cells per group
#' @param M number of genes
#' @param initmean default mean gene expression
#' @param initvar default gene expression variance
#' @param upreg gene expression increase for upregulated genes
#' @param upregvar gene expression variance for upregulated genes
#' @param ng number of upregulated genes per group
simulate.data <- function(G=5, N=30, M=100, initmean=0, initvar=10, upreg=10, upregvar=10, ng=20, seed=0) {
  set.seed(seed)
  mat <- matrix(rnorm(N*M*G, initmean, initvar), M, N*G)
  rownames(mat) <- paste0('gene', 1:M)
  colnames(mat) <- paste0('cell', 1:(N*G))
  group <- factor(sapply(1:G, function(x) rep(paste0('group', x), N)))

  diff <- lapply(1:G, function(x) {
    diff <- rownames(mat)[(((x-1)*ng)+1):(((x-1)*ng)+ng)]
    mat[diff, group==paste0('group', x)] <<- mat[diff, group==paste0('group', x)] + rnorm(ng, upreg, upregvar)
    return(diff)
  })
  names(diff) <- paste0('group', 1:G)

  mat[mat<0] <- 0
  mat <- round(mat)

  return(list(cd=mat, group=group))
}
data <- simulate.data()

###################### Read excel file ##########################
library("xlsx")
# Read signatures
lavin <- read.xlsx("./DOC/Lavin_1-s2.0-S0092867414014494-mmc2.xlsx", sheetName = "Table S1", startRow = 5)

###################### Create GSEA files #########################
lavin.microglia <- tolower(as.character(lavin[which(lavin$X11.Clusters == 1),]$Symbols))
lavin.spleen <- tolower(as.character(lavin[which(lavin$X11.Clusters == 3),]$Symbols))
lavin.lung <- tolower(as.character(lavin[which(lavin$X11.Clusters == 4 | lavin$X11.Clusters == 5),]$Symbols))

# Map signatures to match ENSMUSG ids
lavin.microglia <- unique(t2g[which(tolower(as.character(t2g$ext_gene)) %in% lavin.microglia), "ens_gene"])
lavin.spleen <- unique(t2g[which(tolower(as.character(t2g$ext_gene)) %in% lavin.spleen), "ens_gene"])
lavin.lung <- unique(t2g[which(tolower(as.character(t2g$ext_gene)) %in% lavin.lung), "ens_gene"])

# Prune signatures (min 15 genes. max 500).
# As it is already sorted by expression in microglia we keep the first 500
lavin.microglia <- lavin.microglia[1:500]

data <- as.data.frame(exprs)
data$Name <- rownames(data)
# data <- data[,c("Name", colnames(data)[grep("rep", colnames(data))])]
data <- data[,c("Name", sort(colnames(data)[grep("rep", colnames(data))], decreasing=T))]
# Export for GSEA (tab)
write.table(data, file="./RESULTS/GSEA/-lung3_neutrophils_tissue_expression_gsea.txt", sep="\t", row.names = F, quote=F)

# Create CLS file for GSEA
tissues <- unlist(lapply(strsplit(colnames(data[grep("rep", colnames(data))]), split="_"), `[[`, 1))
line1 <- paste(c(length(grep("rep", colnames(data))),length(unique(tissues)),1), collapse=" ")
line2 <- paste(c("#", unique(tissues)), collapse=" ")
line3 <- paste(tissues, collapse=" ")
fileConn <- file("./RESULTS/GSEA/-lung3_neutrophils_tissue_expression_gsea.cls")
writeLines(c(line1,line2,line3), fileConn)
close(fileConn)

# Create GMT file for GSEA
# First column are gene sets names, second column contains a brief description
# The rest of columns contains one of the genes in the set.
line1 <- paste(c("Microglia_Lavin", "Lavin Microglia MF signature genes"
                 , lavin.microglia), collapse="\t")
line2 <- paste(c("Spleen_Lavin", "Lavin Spleen MF signature genes"
                 , lavin.spleen), collapse="\t")
line3 <- paste(c("Peritoneo_Lavin", "Lavin Peritoneo MF signature genes"
                 , lavin.peritoneo), collapse="\t")

fileConn <- file("./RESULTS/GSEA/-lung3_neutrophils_tissue_signatures_gsea.gmt")
writeLines(c(line1,line2, line3), fileConn)
close(fileConn)

###################### Get pheatmap row ordering ######################
row_order <- hm$tree_row$order


###################### Transform to reg exp ######################
glob2rx('Andy*')

###################### Color gradients with n intercolors ##########################
n=12
colfunc<-colorRampPalette(c("#053061","gray48","#67001F"))
hmcol <- colfunc(n)
plot(rep(1,length(hmcol)),col=(colfunc(length(hmcol))), pch=19,cex=2)
# col2rgb(hmcol)
###################### Create named vecor ##########################
setNames(1:3, c("a", "b", "c"))

###################### Rename columns ##########################
t2g <- dplyr::rename(t2g, target_id = ensembl_transcript_id,
                     ens_gene = ensembl_gene_id, ext_gene = external_gene_name)
###################### Sort vector by another vector ######################
x <- c(2, 2, 3, 4, 1, 4, 4, 3, 3)
y <- c(4, 2, 1, 3)
x[order(match(x,y))]

###################### Sort df by column using vector
order <- tolower(unique(s2c$tissue)) #(order)
column <- matrix$tissue[which(matrix$tissue %in% order)]
matrix <- matrix[order(match(column,order)),]

###################### Group descriptions by field ##########################
t2g.annot <- ddply(t2g.annot, .(ens_gene, ext_gene), summarize, mgi_description = paste(toString(paste(mgi_symbol, ": ", mgi_description, sep=""))))

###################### Get n top genes by column ######################
top10 <- as.data.frame(exprs %>% group_by(tissue) %>% top_n(10, means)) #(dplyr)

###################### Group rows by column and get mean ######################
r <- as.data.frame(results %>% group_by(Gene, Sample.Name) %>% summarise(average = mean(Ct))) #(dplyr)

###################### Exclude items that match regex ###########################
data[,which(!grepl("Blood", colnames(data)))]

###################### Intersection ##########################
Reduce(intersect, list(a,b,c))
Reduce(intersect, list(sig.intestine, sig.skin, sig.brain, sig.lung))

###################### Move columns in a data frame #################
array.data %>% dplyr::select(col_n, everything()) # Move to first position
array.data %>% dplyr::select(col_n, col_x, everything()) # Moves both to the beginning

###################### Calculate means of several columns by group ###########
df.annot <- aggregate(df[, c("col_1", "col2")], list(df$GeneSymbol), mean)
# Mean column By group
aggregate(d[, 3:4], list(d$Name), mean)

###################### Select df minus some columns by name ###############
df <- subset(df, select=-c(amp,per,phase))
###################### Select df minus some rows by name ###############
A <- A[setdiff(rownames(A), "RA"), ]
###################### Select df minus some rows by column content ###############
s2c_parabiont <- s2c_parabiont[!s2c_parabiont$tissue %in% c("Intestine", "Skin"),]

###################### change column types ######################
df[, 1:6] <- sapply(df[, 1:6], as.numeric)

###################### Ordering ######################
column.order.all <- as.character(s2c_all[with(s2c_all, order(batch, rev(depletion), time)),"sample"])
column.order.all <- s2c_filter_all[order(s2c_filter_all$method, -xtfrm(s2c_filter_all$depletion), s2c_filter_all$time), "sample"]

###################### Accessing the 5th element of a list of a splitted list ######################
sapply(strsplit(s2c$file, "_|\\."), "[[", 5)

###################### Access string between two strings ######################
regmatches(v,regexec("STR1(.*?)STR2",v))

###################### Select columns by several patterns ########################
reps_to_subset <- paste(paste("rep", c(1:3), sep=""), collapse='|')
exprs <- exprs[,grep(reps_to_subset, colnames(exprs), value=T)]

###################### Split list into chunks of k elements ######################
n <- length(probes)
k <- 10000
probe_split <- split(probes, rep(1:ceiling(n/k), each=k)[1:n])
for (i in names(probe_split)){
  write.table(unlist(probe_split[i]), paste("probe_", i,".txt", sep="")
              , row.names = FALSE, quote = FALSE, col.names = FALSE)
}

###################### Replace or revalue elements in vector ######################
plyr::revalue(y, c(old1 = "new1", old2 = "new2")) # character
as.numeric(revalue(as.character(data.matrix$clusters.cluster), c("4"="1","1"="2","3"="3","2"="4"))) # numeric

###################### Use rep ######################
rep(1:3, times=6) # 1 2 3 1 2 3 1 2 3 1 2 3 1 2 3 1 2 3
rep(1:3, each=6) # 1 1 1 1 1 1 2 2 2 2 2 2 3 3 3 3 3 3
rep(1:3, length.out=6) #  1 2 3 1 2 3

##################### Merge matrix with vector by names #####################
mat <- matrix(1:9, nrow = 3, ncol = 3)
rownames(mat) <- c("A", "B", "C")
vec <- c("B"=11, "C"=12, "A"=10)
cbind(mat, vec[match(rownames(mat),names(vec))])


###################### ROC curve ######################
# labels is a boolean vector with the actual classification of each case,
# and scores is a vector of real-valued prediction scores assigned by some classifier.
simple_roc <- function(labels, scores){
  labels <- labels[order(scores, decreasing=TRUE)]
  data.frame(TPR=cumsum(labels)/sum(labels), FPR=cumsum(!labels)/sum(!labels), labels)
}

###################### Find percentile 90% ######################
RawData %>% group_by(SampleDate) %>%
  summarise(p90 = quantile(FecalColiform, probs=0.9, na.rm=TRUE))
quantile(FecalColiform, probs=0.9, na.rm=TRUE)


###################### Reverse strings ######################
strReverse <- function(x) sapply(lapply(strsplit(x, NULL), rev), paste, collapse="")

###################### Plot PCA manually ######################
df_pca <- prcomp(t(norm.counts[,1:n.samples]))
plot(df_pca$x[,1], df_pca$x[,2])

#### Al way (plot several)
library("ggplot2")
library("dplyr")
library("tidyr")

gatherpairs <- function(data, ...,
                        xkey = '.xkey', xvalue = '.xvalue',
                        ykey = '.ykey', yvalue = '.yvalue',
                        na.rm = FALSE, convert = FALSE, factor_key = FALSE) {
  vars <- quos(...)
  xkey <- enquo(xkey)
  xvalue <- enquo(xvalue)
  ykey <- enquo(ykey)
  yvalue <- enquo(yvalue)

  data %>% {
    cbind(gather(., key = !!xkey, value = !!xvalue, !!!vars,
                 na.rm = na.rm, convert = convert, factor_key = factor_key),
          dplyr::select(., !!!vars))
  } %>% gather(., key = !!ykey, value = !!yvalue, !!!vars,
               na.rm = na.rm, convert = convert, factor_key = factor_key)
}

mydata <- as.data.frame(df_pca$x[,1:5])
mydata$sample <- rownames(mydata)
mydata <- merge(mydata, s2c[,c("sample", "gender", "group", "QC")], by="sample")


temp <- mydata %>% gatherpairs(PC1, PC2, PC3, PC4, PC5)
# Eliminate dups
temp <- temp[-which(temp$.xkey==temp$.ykey),]
# mydata %>%
#   gatherpairs(PC1, PC2, PC3, PC4, PC5)
temp %>% {
  ggplot(., aes(x = .xvalue, y = .yvalue, color = group, shape=gender)) +
    geom_point() +
    # geom_smooth(method = 'lm') +
    facet_grid(.xkey ~ .ykey
               # , ncol = length(unique(.$.ykey))
               , scales = 'free'
               , labeller = label_parsed
    ) +
    theme(axis.title.x=element_blank()
          # , axis.text.x=element_blank()
          , axis.ticks.x=element_blank()
          , axis.title.y=element_blank()
          # , axis.text.y=element_blank()
          , axis.ticks.y=element_blank()
          , panel.grid.major = element_blank()
          , panel.grid.minor = element_blank()
          , panel.background = element_blank()
          , strip.text = element_text(size=12, face="bold")
          , strip.background = element_rect(fill="white")
    )
}

###################### Kable ######################
kable(s2c, col.names = colnames(s2c), row.names = F , "latex", booktabs = T) %>%
  kable_styling(latex_options = "HOLD_position")

# Multiply by row matrix and vector
p <- matrix(c(1,2,3,4,1,5,6,2,5,5,7,1), nrow=4,ncol=3)
t(t(p)/c(1,2,3))

###################### Monitor memory ######################
Rprof(tf <- "rprof.log", memory.profiling=TRUE)
# [your code]
norm(1:20)
sample(1:100, 3, replace=TRUE)
Rprof(NULL)
summaryRprof(tf)

###################### Venn diagram ######################
library("venn")
tissues <- list(bm=rownames(bm.sig)
                , blood=rownames(bl.sig)
                , spleen=rownames(sp.sig)
                , lung=rownames(lu.sig)
                , intestine=rownames(in.sig))
tissue.sig <- venn(x=tissues
                   , ilab=TRUE
                   , zcolor = "style"
                   , intersections=T
                   , show.plot=T)
intersections <- attr(tissue.sig,"intersections")
bm.sig <- bm.sig[intersections$bm,]

###################### Pheatmap ######################
# Get row order
nls_only_order <- nls_hm$tree_row$order
nls_only_order <- rownames(nls_only[nls_only_order,])
# Get gtable image
hm_bm_kmeans[["gtable"]]
# Convert to ggplot
ggplotify::as.ggplot(all_hm[["gtable"]])

###################### ggplot color palette ######################
gg_color_hue <- function(n) {
  hues = seq(15, 375, length = n + 1)
  hcl(h = hues, l = 65, c = 100)[1:n]
}
n = 6
cols = gg_color_hue(n)

cols <- c("#F8766D", "#7CAE00", "#00BFC4", "#C77CFF")

plot(rep(1,length(cols)),col=cols, pch=19,cex=2)

cols <- c("#36D336", "#576DFC", "#EF7979"
        , "#626697", "#6BFEFF", "#6E7114"
        , "#DFE652", "#FD3B9C", "#089BFF"
        , "#6ADAD7", "#0B6867", "#F8991B"
        , "#6ABD45", "#4766B1", "#4A99B0"
        , "#EE2923")

contrast_cols <- c("#800000" # Maroon
                 , "#9A6324" # Brown
                 , "#808000" # Olive
                 , "#469990" # Teal
                 , "#000075" # Navy
                 , "#000000" # Black
                 , "#e6194B" # Red
                 , "#f58231" # Orange
                 , "#ffe119" # Yellow
                 , "#bfef45" # Lime
                 , "#3cb44b" # Green
                 , "#42d4f4" # Cyan
                 , "#4363d8" # Blue
                 , "#911eb4" # Purple
                 , "#f032e6" # Magenta
                 , "#a9a9a9" # Grey
                 , "#fabebe" # Pink
                 , "#ffd8b1" # Apricot
                 , "#fffac8" # Beige
                 , "#aaffc3" # Mint
                 , "#e6beff" # Lavender
                   )

###################### Package version ######################
packageVersion("Seurat")

capitalize <- function(x) {
  s <- paste(toupper(substring(x, 1,1)), tolower(substring(x, 2)),
        sep="", collapse=" ")
  return(s)
}
