# R env in Rstudio

## Push the docker

```bash
docker push rocker/rstudio:4.2.1
docker run -d --name sle_rstudio --hostname rstudio -P -p 8787:8787 -v /your/path:/data rocker/rstudio:4.2.1
```

## Install packages manually
Install the following packages in Rstudio
- Seurat
- monocle2
- CellChat
- nichenetr
- harmony
- scRepertoire
- immunarch
- shazam
- tidyverse
- ggpubr
- cowplot
- data.table
- sceasy
- fgsea
- msigdbr
- presto
- clusterProfiler

## Install packages via renv (Optional)

```R
install.packages('renv')
renv::restore()
```

# Python env
Please install following packages in python > 3.8 in a new conda environment.
- snakemake 
- scanpy
- scvelo
- pySCENIC
- CoNGA
- loompy

# Additional packages
You also need install [VDJtools](https://vdjtools-doc.readthedocs.io/en/master/#) manually, which relies on Java.
