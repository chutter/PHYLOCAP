#' @title alignmentAssess
#'
#' @description Function for assessing whether an entire alignment meets certain criteria
#'
#' @param alignment alignment in DNAStringSet Format
#'
#' @param max.alignment.gap.percent minimum percentage of gaps allowed for an alignment to pass
#'
#' @param min.taxa.count minimum number of taxa allowed for an alignment to pass
#'
#' @param min.align.length minimum alignment length (width) allowed for an alignment to pass
#'
#' @return a logical value, TRUE or FALSE, if your alignment passes (TRUE) or fails (FALSE) the filters
#'
#' @examples
#'
#' your.tree = ape::read.tree(file = "file-path-to-tree.tre")
#' astral.data = astralPlane(astral.tree = your.tree,
#'                           outgroups = c("species_one", "species_two"),
#'                           tip.length = 1)
#'
#'
#' @export

#Assesses the alignment returning TRUE for pass and FALSE for fail
alignmentAssess = function(alignment = NULL,
                           max.alignment.gap.percent = 0,
                           min.taxa.alignment = 0,
                           min.alignment.length = 0){
  #Count gaps
  #alignment = non.align
  gap.data = countAlignmentGaps(alignment)
  #if (length(gap.data) != 3){ return(FALSE) }

  #Checks for enough data
  if (length(gap.data) <= 2){ return(FALSE) }

  #Checks for min percentage
  if (gap.data[3] >= max.alignment.gap.percent) {
    return(FALSE)
  }

  #Make a summary table thing
  if (length(alignment) <= min.taxa.alignment){
    return(FALSE)
  }

  if (max(Biostrings::width(alignment)) <= min.alignment.length){
    return(FALSE)
  }

  return(TRUE)

}#end function

