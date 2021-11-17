# demo-regularisation
**Regularisation and Cross-Validation: Demonstration for R**

[![Version](https://img.shields.io/badge/version-v0.3.2-blue.svg)](CHANGELOG.md) [![Project Status: WIP – Initial development is in progress, but there has not yet been a stable, usable release suitable for the public.](https://www.repostatus.org/badges/latest/wip.svg)](STATUS.md) [![GitHub issues](https://img.shields.io/github/issues/bgonzalezbustamante/demo-regularisation.svg)](https://github.com/bgonzalezbustamante/demo-regularisation/issues/) [![GitHub issues-closed](https://img.shields.io/github/issues-closed/bgonzalezbustamante/demo-regularisation.svg)](https://github.com/bgonzalezbustamante/demo-regularisation/issues?q=is%3Aissue+is%3Aclosed) [![DOI](https://img.shields.io/badge/DOI-TBC-blue)](CHANGELOG.md) [![License](https://img.shields.io/badge/license-CC--BY--4.0-black)](LICENSE.md) [![R](https://img.shields.io/badge/made%20with-R%20v4.1.0-1f425f.svg)](https://cran.r-project.org/)

## Overview

This repository contains a demonstration for R of regularisation, shrinkage, and cross-validation methods. The application of these techniques is for illustrative purposes only. Chunks of this code for extraction and handling V-Dem and World Bank data were used in the following article:

- González-Bustamante, B. (2021). Early Government Responses to COVID-19 in South America. *World Development, 137*, 105180. DOI: [10.1016/j.worlddev.2020.105180](https://doi.org/10.1016/j.worlddev.2020.105180)

Further details and different applications on this [GitHub repository](https://bgonzalezbustamante.github.io/COVID-19-South-America/) and this OSF-Project (DOI: 10.17605/OSF.IO/6FM7X).

## Metadata and Preservation

This code is stored with version control on a GitHub repository. Furthermore, a Digital Object Identifier is provided by Zenodo. The structure of the repository is detailed below.

*demo-regularisation* \
|-- CHANGELOG.md \
|-- code \
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|-- stage_1_data_cleaning.R \
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|-- stage_2_regularisation.R \
|-- data \
|-- demo-regularisation.Rproj \
|-- LICENSE.md
|-- .gitignore \
|-- output \
|-- README.md

XX directories and XX files.

In addition, this README file in Markdown (MD) format provides specific information to ensure the replicability of the code.

## Store and Backup

The GitHub repository has controlled access with Two-Factor Authentication (2FA) with two physical USB security devices (Bastián González-Bustamante, [ORCID iD 0000-0003-1510-6820](https://orcid.org/0000-0003-1510-6820)). Both USB keys issue one-time passwords to generate a cryptographic authentication FIDO 2 and U2F.

## Getting Started

### Software

We use R version 4.1.0 (2021-05-18) -- "Camp Pontanezen".

Required R libraries are: TBC.

We recommend that users run replication code and scripts from the root directory using the R project "demo-regularisation.Rproj".

### Replication Instructions

The folder "output" contains all tables provided as .html files and plots in .jpg format.

These files will be overwritten if you reproduced the steps described below. 

- **Stage 1.** Run R script "stage_1_data_cleaning.R" from the code folder. This script splits V-Dem data<sup id="a1">[1](#f1)</sup> and merges them with World Bank indicators on GDP growth and inflation. Then, a significantly smaller and more manageable data set is saved in XXX format on this repository.

- **Stage 2.** Run R script "stage_2_regularisation.R" from the code folder. This script contains the regularisation and cross-validation demonstration for R.

- **Stage 3.** 

It is possible to run the code from the second stage onward to check the methods directly. Considering the volume of V-Dem data (XXX), running the first code takes some time.

### Codebook

WIP

## License

This R code is released under a [Creative Commons Attribution 4.0 International license (CC BY 4.0)](LICENSE.md). This open-access license allows the data to be shared, reused, adapted as long as appropriate acknowledgement is given.

## Citation

WIP

## Author

Bastián González-Bustamante \
bastian.gonzalezbustamante@politics.ox.ac.uk \
[ORCID iD 0000-0003-1510-6820](https://orcid.org/0000-0003-1510-6820) \
https://bgonzalezbustamante.com 

## CRediT - Contributor Roles Taxonomy

Bastián González-Bustamante ([ORCID iD 0000-0003-1510-6820](https://orcid.org/0000-0003-1510-6820)) \
<img src="https://github.com/bgonzalezbustamante/open_research_badges/blob/master/img/badges/conceptualization.png" align="left" width="55" />
<img src="https://github.com/bgonzalezbustamante/open_research_badges/blob/master/img/badges/data_curation.png" align="left" width="55" />
<img src="https://github.com/bgonzalezbustamante/open_research_badges/blob/master/img/badges/formal_analysis.png" align="left" width="55" />
<img src="https://github.com/bgonzalezbustamante/open_research_badges/blob/master/img/badges/methodology.png" align="left" width="55" />
<img src="https://github.com/bgonzalezbustamante/open_research_badges/blob/master/img/badges/project_administration.png" align="left" width="55" />
<img src="https://github.com/bgonzalezbustamante/open_research_badges/blob/master/img/badges/resources.png" align="left" width="55" />
<img src="https://github.com/bgonzalezbustamante/open_research_badges/blob/master/img/badges/computation.png" align="left" width="55" />
<img src="https://github.com/bgonzalezbustamante/open_research_badges/blob/master/img/badges/testing.png" align="left" width="55" />
<img src="https://github.com/bgonzalezbustamante/open_research_badges/blob/master/img/badges/data_visualization.png" align="left" width="55" /> <br /><br />

### Notes

1. <small id="f1">V-Dem [Country–Year/Country–Date] Dataset v10 (Coppedge et al., 2020; DOI: https://doi.org/10.23696/vdemds20.) is downloaded from our OSF-project on COVID-19 in South America (DOI: TBC) during the first stage. However, it is important to bear in mind that the current version is 11.1.</small> [↩](#a1)

### Latest Revision

[November 17, 2021](CHANGELOG.md).
