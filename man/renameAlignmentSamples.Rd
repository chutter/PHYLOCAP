% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/renameAlignmentSamples.R
\name{renameAlignmentSamples}
\alias{renameAlignmentSamples}
\title{renameAlignmentSamples}
\usage{
renameAlignmentSamples(
  align.directory = NULL,
  align.extension = ".phy",
  rename.file = NULL,
  recursive = TRUE
)
}
\arguments{
\item{align.directory}{the directory of alignments to have their samples renamed}

\item{align.extension}{the file extension of your alignment files to be named}

\item{rename.file}{a tab delimited text file with two columns named Old_Name and New_Name for the current and new name of the target sample}

\item{recursive}{TRUE to recursively rename within sub-directories or FALSE just for the main directory}
}
\value{
overwrites alignments in directory with renamed sample alignments
}
\description{
Function for easily renaming the samples of a multiple sequence alignment within a directory, or a single alignment
}
\examples{

your.tree = ape::read.tree(file = "file-path-to-tree.tre")
astral.data = astralPlane(astral.tree = your.tree,
                          outgroups = c("species_one", "species_two"),
                          tip.length = 1)


}
