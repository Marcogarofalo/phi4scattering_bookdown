# example R options set globally
#options(width = 60)

# example chunk options set globally
knitr::opts_chunk$set(
  comment = "#>",
  collapse = TRUE
  )

knitr::opts_chunk$set(echo = FALSE, warning = FALSE, result='asis')

library(ggplot2)
library(plotly)

library(htmlwidgets)
library(pander)
#library(latex2exp)
library(knitr)
library(dplyr) #data frame manipulation
library(tidyverse)
require(scales) # to access break formatting functions
#library(shiny)
#library(shinyWidgets)
library(ggrepel)
library(Rose)
library(widgetframe)
require("processx")
library(webshot)
library(htmltools)
# library(sigma)
source('functions.R')