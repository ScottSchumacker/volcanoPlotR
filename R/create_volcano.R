#'Build a volcano plot with create_volcano()
#'
#'This function can be used to build a volcano plot from Kallisto outputs to visualize your genomic or transcriptomic data.
#'
#'@import ggplot2
#'@import dplyr
#'@import ggrepel
#'@import cowplot
#'@importFrom utils read.csv
#'@importFrom assertthat assert_that is.readable
#'
#'@param dataPath A file path to locate your data
#'@param bioSig A numeric value representing biological significant
#'@param statSig A numeric value representing statistical significant
#'
#'@return This function returns a volcano plot
#'@export
#'
# Creating volcano function
create_volcano <- function(dataPath, bioSig, statSig){

  # Assert that datapath is readable
  assert_that(is.readable(dataPath), msg = "Data path is not readable. Check for errors within the path.")

  # Assert that bioSig is of class numeric
  assert_that(is.numeric(bioSig), msg = "bioSig needs to be a numeric value")

  # Assert that statsig is of class numeric
  assert_that(is.numeric(statSig), msg = "statSig needs to be a numeric value")

  # Reading in data
  readData <- read.csv(file= dataPath,
                       header=TRUE, sep=",")

  # Differentiating significant data
  analyzedData <- mutate(readData, sig=ifelse(readData$qval<statSig, "Statistically Significant", "Not Significant"))

  # Creating the volcano plot
  volcanoPlot = ggplot(analyzedData, aes(b, -log10(qval))) + geom_point(aes(x=b, y=-log10(qval),
                                                                            color = ifelse(-log10(qval)>-log10(statSig), "Statistically Significant", "no")), size=1.5)

  volcanoPlot <- volcanoPlot + geom_point(aes(x=b, y = -log10(qval), color = ifelse(b < -bioSig & -log10(qval) > -log10(statSig) | b > bioSig & -log10(qval) > -log10(statSig), "Biologically and Statistically Significant" , NA)))
  volcanoPlot <- volcanoPlot + geom_point(aes(x=b, y = -log10(qval), color = ifelse(-log10(qval) < -log10(statSig) & (b) <= -bioSig | (-log10(qval) < -log10(statSig) & (b) > bioSig), "Biologically Significant", NA)))
  volcanoPlot <- volcanoPlot + scale_color_manual(values = c("green", "orange", "black","red"), label = c("no" = "Not Signficant"))
  volcanoPlot <- volcanoPlot + geom_vline(xintercept=c(-bioSig, bioSig), linetype="dashed")
  volcanoPlot <- volcanoPlot + geom_hline(yintercept=c(-log10(statSig)), linetype="dashed")
  return(volcanoPlot)

}
