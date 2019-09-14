# volcanoPlotR - Package

### volcanoPlotR is an R package developed to create custom volcano plots from genomic and transcriptomic expression data. In order for this package work properly, the data should have been processed upstream with Kallisto and Sleuth.

#### Instructions on installing and loading the package:
1. install.packages("devtools)
2. library(devtools)
3. install_github("ScottSchumacker/volcanoPlotR")
4. library(volcanoPlotR)

#### Instructions on how to use the package:
1. The function has three parameters: create_volcano(dataPath, bioSig, statSig).
2. bioSig should be a significant log2FC or beta cutoff value.
3. statSig should be a cutoff value representing statistical significant.

##### Example:
create_volcano(dataPath = "", bioSig = 1.5, statSig = 0.05)
