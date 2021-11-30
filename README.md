# demo-regularisation
**Regularisation and Cross-Validation of Determinants of Egalitarian Democracy: Demonstration for R**

[![Version](https://img.shields.io/badge/version-v1.1.1-blue.svg)](CHANGELOG.md) [![Project Status: Inactive – The project has reached a stable, usable state but is no longer being actively developed; support/maintenance will be provided as time allows.](https://www.repostatus.org/badges/latest/inactive.svg)](STATUS.md) [![GitHub issues](https://img.shields.io/github/issues/bgonzalezbustamante/demo-regularisation.svg)](https://github.com/bgonzalezbustamante/demo-regularisation/issues/) [![GitHub issues-closed](https://img.shields.io/github/issues-closed/bgonzalezbustamante/demo-regularisation.svg)](https://github.com/bgonzalezbustamante/demo-regularisation/issues?q=is%3Aissue+is%3Aclosed) [![DOI](https://zenodo.org/badge/428344428.svg)](https://zenodo.org/badge/latestdoi/428344428) [![License](https://img.shields.io/badge/license-CC--BY--4.0-black)](LICENSE.md) [![R](https://img.shields.io/badge/made%20with-R%20v4.1.0-1f425f.svg)](https://cran.r-project.org/)

## Overview

This repository contains a demonstration for R of regularisation, cross-validation, and shrinkage methods. The application of these techniques is for illustrative purposes only on determinants of egalitarian democracy. The results should not be considered for any interpretation since it is necessary to develop a causal identification strategy and apply a number of controls, adjustments to standard errors, and robustness checks.

Chunks of this code for extraction and handling V-Dem and World Bank data were used in the following article:

- González-Bustamante, B. (2021). Early Government Responses to COVID-19 in South America. *World Development, 137*, 105180. DOI: [10.1016/j.worlddev.2020.105180](https://doi.org/10.1016/j.worlddev.2020.105180)

Further details and different applications on this [GitHub repository](https://bgonzalezbustamante.github.io/COVID-19-South-America/) and this OSF-Project (DOI: [10.17605/OSF.IO/6FM7X](https://doi.org/10.17605/OSF.IO/6FM7X)).

## Metadata and Preservation

This code is stored with version control on a GitHub repository. Furthermore, a Digital Object Identifier is provided by Zenodo. The structure of the repository is detailed below.

*demo-regularisation* \
|-- .gitignore \
|-- CHANGELOG.md \
|-- CITATION.cff \
|-- demo-regularisation.Rproj \
|-- LICENSE.md \
|-- README.md \
|-- STATUS.md \
|-- code \
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|-- regularisation_demo.md \
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|-- regularisation_demo.R \
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|-- regularisation_demo.Rmd \
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|-- stage_1_data_cleaning.R \
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|-- stage_2_regularisation.R \
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|-- regularisation_demo_files \
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|-- figure-gfm \
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|-- lasso-1.png \
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|-- lasso-2.png \
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|-- ols-1.png \
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|-- ridge-1.png \
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|-- ridge-2.png \
|-- data \
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|-- vdem_wb.csv \
|-- output \
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|-- table_1.html \
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|-- table_2.html 

5 directories and 20 files.

In addition, this README file in Markdown (MD) format provides specific information to ensure the replicability of the code.

## Store and Backup

The GitHub repository has controlled access with Two-Factor Authentication (2FA) with two physical USB security devices (Bastián González-Bustamante, [ORCID iD 0000-0003-1510-6820](https://orcid.org/0000-0003-1510-6820)). Both USB keys issue one-time passwords to generate a cryptographic authentication FIDO2 and U2F.

## Getting Started

### Software

We use R version 4.1.0 (2021-05-18) -- "Camp Pontanezen".

Required R libraries are: "broom", "caret", "coefplot", "glmnet", "tidyverse", "stargazer", and "wbstats".

We recommend that users run replication code and scripts from the root directory using the R project "**demo-regularisation.Rproj**".

### Replication Instructions

Folder "code" contains the R scripts and a demonstration in RMD and MD formats (**[regularisation_demo.md](code/regularisation_demo.md)**). On the other hand, "output" includes all tables provided as HTML files.

These files will be overwritten if you reproduced the steps described below. 

- **Stage 1.** Run R script "**stage_1_data_cleaning.R**" from the code folder. This script splits V-Dem data[^1] and merges them with World Bank indicators[^2] on GDP growth and inflation. Then, a significantly smaller and more manageable data set is saved in CSV UTF-8 format (1.57 MB) on this repository.

- **Stage 2.** Run R script "**stage_2_regularisation.R**" from the code folder. This script contains the demonstration for R. Alternatively, it is possible to run "regularisation_demo.Rmd" and the files in "code/regularisation_demo_files" subfolder will be overwritten.

It is possible to run the code from the second stage onward to check the methods directly. Considering the volume of V-Dem data (182 MB), running the first script takes some time.

### Codebook

The file "**vdem_wb.csv**" in "data" folder is the merged, sliced data set from V-Dem and World Bank (*N* = 27,013). This set contains country-year observations from 1789 to 2019 of 202 countries.

- **country** (country_name in V-Dem). Country name.

- **year**. Year variable.

- **egal_dem** (v2x_egaldem in V-Dem). The egalitarian democracy index considers freedoms protected across all social groups, resources distributed equally across all social groups, and equal access to power. It also takes into account the level of electoral democracy.

- **corruption** (v2x_corr in V-Dem). The political corruption index measures how pervasive is political corruption and considers measures of six distinct types of corruption from different areas of the political field, distinguishing between executive, legislative, and judicial corruption.

- **military** (v2x_ex_military in V-Dem). The military dimension index measures if the military determines the chief executive's power base based on appointments made through a coup or rebellions and if the military can remove them.

- **free_exp** (v2x_freexp in V-Dem). The freedom of expression index reflects the government's level of respect for press and media freedom, the freedom to discuss political matters in the public sphere, and freedom of academic and cultural expressions.

- **fed_uni** (v2x_feduni in V-Dem). The division of power index reflects if the local and regional governments are elected and the level of independence in the decision-making process.

- **inflation** (FP.CPI.TOTL.ZG in World Bank API). Inflation based on consumer prices (annual percentage).

- **gdp** (NY.GDP.MKTP.KD.ZG in World Bank API). GDP growth (annual percentage).

- **gdp_pc** (NY.GDP.PCAP.KD.ZG in World Bank API). GDP per capita growth (annual percentage).

## License

This R code and merged, sliced data set from V-Dem and World Bank are released under a [Creative Commons Attribution 4.0 International license (CC BY 4.0)](LICENSE.md). This open-access license allows the data to be shared, reused, adapted as long as appropriate acknowledgement is given.

## Contribute

Contributions are entirely welcome. You just need to [open an issue](https://github.com/bgonzalezbustamante/demo-regularisation/issues/new) with your comment or idea.

For more substantial contributions, please fork this repository and make changes. Pull requests are also welcome.

Please read our [code of conduct](CODE_OF_CONDUCT.md) first. Minor contributions will be acknowledged, and significant ones will be considered on our contributor roles taxonomy.

## Citation

González-Bustamante, B. (2021). Regularisation and Cross-Validation of Determinants of Egalitarian Democracy: Demonstration for R (Version 1.1.1 -- Autumn Mode) [Computer software]. DOI: [10.5281/zenodo.5708892](https://doi.org/10.5281/zenodo.5708892)

## Author

Bastián González-Bustamante \
bastian.gonzalezbustamante@politics.ox.ac.uk \
[ORCID iD 0000-0003-1510-6820](https://orcid.org/0000-0003-1510-6820) \
https://bgonzalezbustamante.com 

## CRediT - Contributor Roles Taxonomy

Bastián González-Bustamante ([ORCID iD 0000-0003-1510-6820](https://orcid.org/0000-0003-1510-6820)): Conceptualisation, data curation, formal analysis, methodology, project administration, resources, software, validation, and visualisation.

### Latest Revision

[November 30, 2021](CHANGELOG.md).

[^1]: V-Dem [Country–Year/Country–Date] Dataset v10 (Coppedge et al., 2020; DOI: https://doi.org/10.23696/vdemds20.) is downloaded from our OSF-project on COVID-19 in South America (DOI: [10.17605/OSF.IO/6FM7X](https://doi.org/10.17605/OSF.IO/6FM7X)) during the first stage. However, it is important to bear in mind that the current data set is v11.1.
[^2]: Data downloaded during the first stage from the World Bank API.
