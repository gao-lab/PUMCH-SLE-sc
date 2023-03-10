library(RColorBrewer)
load("final/scRepertoire/BCR/combined_bcr.rdata")

################################################################################
#
# Do NOT use this script because it had been desert !!!
#
################################################################################

# we should filter the BCR and than analysis them with RNA together!
# please see 03_bcr_with_bcell.R



################################################################################
#
# Read and filter the BCR
#
################################################################################

# we find it will get different result when using not filtered BCR repertoire and filtered by seurat barcode

combined_bcr <- addVariable(combined_bcr, name = "group",
                            variables = c("before", "before", "before", "after", "before", "before", "before", "after", "before", "HC", "before",
                                        "before", "after", "before", "before", "after", "after", "HC", "HC", "before", "after", "HC"))

bcell_rna_meta <- read.csv("./vdj/immcatation/analysis/seurat_bcell_filter_meta.csv")
plasma_rna_meta <- read.csv("./vdj/immcatation/analysis/seurat_plasma_filter_meta.csv")

combined_bcr.df <- rbindlist(combined_bcr)
combined_bcr.df %<>% filter(barcode %in% c(bcell_rna_meta$X, plasma_rna_meta$X))


################################################################################
#
# Quantify BCR repertoire
#
################################################################################

quantContig(combined_bcr, cloneCall = "gene+nt", scale = T, chain = "both",group.by = "group") +
    stat_compare_means(comparisons = list(c("after", "before"), c("before", "HC"), c("after", "HC")),  method = "t.test",
                       bracket.size = 0.5)

quantContig(combined_bcr, cloneCall = "aa", scale = T, chain = "both",group.by = "group") +
    stat_compare_means(comparisons = list(c("after", "before"), c("before", "HC"), c("after", "HC")),  method = "t.test",
                       bracket.size = 0.5)

clonalHomeostasis(combined_bcr, cloneCall = "aa")
# quantContig(combined_bcr, cloneCall = "gene+nt", scale = T, chain = "both",group.by = "ID")

clonalOverlap(combined_bcr, cloneCall = "aa",
            method = "morisita") + scale_x_discrete(guide = guide_axis(n.dodge = 2))

# only shannon and inv.simpson is notable
clonalDiversity(combined_bcr, cloneCall = "aa", group.by = "sample",
                x.axis = "group", n.boots = 100) +
    stat_compare_means(comparisons = list(c("after", "before"), c("before", "HC"), c("after", "HC")),
                        method = "t.test")




vizGenes(combined_bcr[c(9, 18, 19, 22)], gene = "V", chain = "IGH",
        y.axis = "J", plot = "heatmap", scale = TRUE, order = "gene")

vizGenes(combined_bcr[-c(9, 18, 19, 22)], gene = "V", chain = "IGH",
        y.axis = "J", plot = "heatmap", scale = TRUE, order = "gene")
