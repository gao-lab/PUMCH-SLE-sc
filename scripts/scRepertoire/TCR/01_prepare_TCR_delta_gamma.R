library(scRepertoire)
library(stringr)
# library(immunarch)
library(Seurat)

################################################################################
#
# This script had been desert because we do not find delta gamma TCR
#
################################################################################

stop("you are running desert script")

setwd("/data/sle/")
output_path <- "./final/scRepertoire/TCR/"

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

contig_list_bcr <- list(S1_bcr.csv, S2_bcr.csv, S3_bcr.csv, S4_bcr.csv, S5_bcr.csv,
                        S6_bcr.csv, S7_bcr.csv, S8_bcr.csv, S9_bcr.csv, S10_bcr.csv,
                        S11_bcr.csv, S12_bcr.csv, S13_bcr.csv, S14_bcr.csv, S15_bcr.csv,
                        S16_bcr.csv, S17_bcr.csv, S18_bcr.csv, S19_bcr.csv, S20_bcr.csv,
                        S21_bcr.csv, S22_bcr.csv)

# combined_tcr <- combineTCR(contig_list_tcr,
#                            samples = tcr_sample_name,
#                            ID = tcr_id)
back_run(combineTCR, out_name = "combined_tcr", job_name = "combined_tcr",
        contig_list_tcr, samples = tcr_sample_name, ID = tcr_id)

# rm(list(tcr_sample,tcr_sample_name,tcr_id,tcr_group,contig_list))


#------------------------------ Save File --------------------------------------
save(combined_tcr, file = "final/scRepertoire/TCR/combined_tcr_delta_gamma.rdata")
