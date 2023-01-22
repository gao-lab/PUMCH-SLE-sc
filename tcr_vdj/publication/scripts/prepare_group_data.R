library(scRepertoire)

# read in data
tcr_sample <- list.files("./data/10x_tcr/", pattern = "csv$")

tcr_list <- list()
for (i in tcr_sample) {
    tmp <- as.data.frame(read.csv(paste0("./data/10x_tcr/",i)))
    tmp$sample <- str_split_fixed(i, pattern = "_", 2)[, 1]
    assign(i, tmp)
    rm(tmp)
}

contig_list_tcr <- list(S1_tcr.csv,S2_tcr.csv,S3_tcr.csv,S4_tcr.csv,S5_tcr.csv,
                        S6_tcr.csv,S7_tcr.csv,S8_tcr.csv,S9_tcr.csv,S10_tcr.csv,
                        S11_tcr.csv,S12_tcr.csv,S13_tcr.csv,S14_tcr.csv,S15_tcr.csv,
                        S16_tcr.csv,S17_tcr.csv,S18_tcr.csv,S19_tcr.csv,S20_tcr.csv,
                        S21_tcr.csv,S22_tcr.csv)
contig_list_tcr <- rbindlist(contig_list_tcr)
head(contig_list_tcr)

# add the meta
meta <- unique(pbmc_all@meta.data[, c("treatment", "orig.ident")]) %>% remove_rownames() %>% column_to_rownames("orig.ident")
contig_list_tcr <- left_join(contig_list_tcr, rownames_to_column(meta),
                                by = c("sample" = "rowname"))
contig_list_tcr$barcode <- paste0(contig_list_tcr$sample, "_", contig_list_tcr$treatment, "_", contig_list_tcr$barcode)

# filter the data
t_cell_merge <- merge(cd4_filter, y = c(cd8_filter, other_T_filter, nk_filter, prolife_T_filter))
contig_barcode <- t_cell_merge@meta.data %>% rownames_to_column("barcode") %>%
    mutate(new_barcode = str_split_fixed(barcode, "_", 2)[, 1]) %>%
    mutate(contig_barcode = paste0(orig.ident, "_", treatment, "_", new_barcode)) %>% select(contig_barcode)

t_cell_merge <- RenameCells(t_cell_merge, new.names = contig_barcode$contig_barcode)
intersect(Cells(t_cell_merge), contig_list_tcr$barcode) %>% length()

contig_list_tcr_filter <- contig_list_tcr[contig_list_tcr$barcode %in% Cells(t_cell_merge), ]

# group the data
for (group in contig_list_tcr_filter$treatment %>% unique()) {
    for (tcr_chain in  contig_list_tcr_filter$chain %>% unique()) {
        print(group);print(tcr_chain)
        tmp <- contig_list_tcr_filter %>% filter(treatment == group & chain == tcr_chain)
        print(dim(tmp))
        write_csv(tmp, file = paste0("./tcr_vdj/publication/input/", group, "_", tcr_chain, "_tcr.csv"), col_names = T)
    }
}

