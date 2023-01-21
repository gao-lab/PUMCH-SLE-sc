library(cowplot)
library(harmony)
library(Seurat)
library(future)

setwd("/data/sle")
source("./scripts/function_R/utils.R")

load("final/seurat/t_cell/03-prolife_Tcell_raw_harm.rdata")
prolife_T_filter <- prolife_T_harm
prolife_T_filter$subtype <- "T.prolife_T"
save(prolife_T_filter, file = "final/seurat/t_cell/04-prolife_Tcell_filter.rdata")
