library(scRepertoire)
library(stringr)
library(Seurat)

setwd("/data/sle/")
output_path <- "./final//scRepertoire/TCR/"

#------------------------------ Read File --------------------------------------
tcr_sample <- list.files("./data/10x_tcr/", pattern = "csv$")
tcr_sample_name <- str_split_fixed(tcr_sample, pattern = "_", 2)[, 1]

tcr_list <- list()
for (i in tcr_sample) {
    assign(i, as.data.frame(read.csv(paste0("./data/10x_tcr/", i))))
}


#------------------------------ Add Meta ---------------------------------------
tcr_id <- c("SLE", "SLE", "SLE", "SLE", "SLE", "SLE", "SLE", "SLE", "SLE", "HC",
           "SLE", "SLE", "SLE", "SLE", "SLE", "SLE", "SLE", "HC", "HC", "SLE",
           "SLE", "HC")
tcr_group <- c("none", "none", "before", "after", "none",
              "none", "before", "after", "none", "HC",
              "none", "before", "after", "none", "before",
              "after", "after", "HC", "HC", "before",
              "after", "HC")

contig_list_tcr <- list(S1_tcr.csv, S2_tcr.csv, S3_tcr.csv, S4_tcr.csv, S5_tcr.csv,
                        S6_tcr.csv, S7_tcr.csv, S8_tcr.csv, S9_tcr.csv, S10_tcr.csv,
                        S11_tcr.csv, S12_tcr.csv, S13_tcr.csv, S14_tcr.csv, S15_tcr.csv,
                        S16_tcr.csv, S17_tcr.csv, S18_tcr.csv, S19_tcr.csv, S20_tcr.csv,
                        S21_tcr.csv, S22_tcr.csv)
                        

#------------------------------ Save File --------------------------------------
save(combined_tcr, file = "final/scRepertoire/TCR/combined_tcr.rdata")