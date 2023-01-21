# R env in Rstudio

## Push the docker

```bash
docker push rocker/rstudio:4.0.3
docker run -d --name sle_rstudio --hostname rstudio -P -p 8787:8787 -v /your/path:/data rocker/rstudio:4.0.3
```

## Install packages via renv

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

# Additional packages
You also need install [VDJtools](https://vdjtools-doc.readthedocs.io/en/master/#) manually, which relies on Java.
