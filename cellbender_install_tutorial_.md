Cellbender package installation on Alpine:
======================================

According to the cellbender [page](https://github.com/broadinstitute/CellBender/tree/master), "CellBender is a software package for eliminating technical artifacts from high-throughput single-cell RNA sequencing (scRNA-seq) data."
To reference this package, please cite:

Citing CellBender
-----------------

If you use CellBender in your research (and we hope you will), please consider
citing our paper in Nature Methods:

Stephen J Fleming, Mark D Chaffin, Alessandro Arduini, Amer-Denis Akkad,
Eric Banks, John C Marioni, Anthony A Phillipakis, Patrick T Ellinor,
and Mehrtash Babadi. Unsupervised removal of systematic background noise from
droplet-based single-cell experiments using CellBender.
`Nature Methods`, 2023. https://doi.org/10.1038/s41592-023-01943-7

See also `our preprint on bioRxiv <https://doi.org/10.1101/791699>`_.

Below are the following steps in order to install CellBender on Alpine:

## CellBender package installation steps.

1) Step 1: Always make sure that you have a .condarc file configured as [here](https://curc.readthedocs.io/en/latest/software/python.html#configuring-conda-with-condarc)

2) Step 2: Log into an Alpine compute node. We typically use the acompile partition to install packages. For more info on acompile please refer to [here](https://curc.readthedocs.io/en/latest/clusters/alpine/important-notes.html#important-notes)
   Below, we are requesting 4 cores to slurm and a walltime of 4 hours. For more information about cores please refer to pages 3 to 5 [here](file:///Users/Fotsok/Downloads/Entry_level_workshop_030524_v2-52.pdf)

```bash
acompile --ntasks=4 --time=04:00:00
```

3) Step 3 


