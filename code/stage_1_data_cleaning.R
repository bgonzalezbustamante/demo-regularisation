## +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

#### Script ID ####

## +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

## Script Data Cleaning: V-Dem and World Bank
## R version 4.1.0 (2021-05-18) -- "Camp Pontanezen"
## Date: November 2021

## Bastián González-Bustamante (University of Oxford, UK)
## ORCID iD 0000-0003-1510-6820
## https://bgonzalezbustamante.com

## Regularisation and Cross-Validation: Demonstration for R
## https://github.com/bgonzalezbustamante/demo-regularisation/

## +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

#### Packages and Data ####

## +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

## Clean Environment
rm(list = ls())

## Packages
library(wbstats)
library(tidyverse)

## Data from OSF Repository
vdem <- read.csv("https://osf.io/r7v3p/download")

## Select Variables
vdem <- select(vdem, country_name, year, v2x_egaldem, v2x_corr, v2x_ex_military,
               v2x_freexp, v2x_feduni)
names(vdem)[1] = "country"
names(vdem)[3] = "egal_dem"
names(vdem)[4] = "corruption"
names(vdem)[5] = "military"
names(vdem)[6] = "free_exp"
names(vdem)[7] = "fed_uni"

## Wolrd Bank Data
new_cache <- wb_cache()
wb_set <- wb_data(indicator = c("NY.GDP.MKTP.KD.ZG", "NY.GDP.PCAP.KD.ZG", "FP.CPI.TOTL.ZG"))
## FP.CPI.TOTL.ZG: Inflation, consumer prices (annual %)
## NY.GDP.MKTP.KD.ZG: GDP growth (annual %)
## NY.GDP.PCAP.KD.ZG: GDP per capita growth (annual %)
names(wb_set)[4] = "year"
names(wb_set)[5] = "inflation"
names(wb_set)[6] = "gdp"
names(wb_set)[7] = "gdp_pc"

## Merging
vdem_wb <- left_join(vdem, wb_set[-1:-2], by = c("country", "year"))

## Save Clean Data
write.csv(vdem_wb, "data/vdem_wb.csv", fileEncoding = "UTF-8", row.names =  FALSE)
