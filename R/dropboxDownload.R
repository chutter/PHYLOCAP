#' @title dropboxDownload
#'
#' @description Function for downloading data off your dropbox account
#'
#' @param sample.spreadsheet spreadsheet path or table of file names to download
#'
#' @param dropbox.directory the directory that contains these target files
#' 
#' @param dropbox.token your dropbox token path, created the first time you run the function but needs interactivity for log-in. Can be done once on your computer and the token can be moved around. 
#'
#' @param out.directory the directory to save the files you are downloading
#'
#' @param overwrite whether to overwrite or not
#'
#' @return saves dropbox files to output directory 
#'
#' @examples
#'
#' your.tree = ape::read.tree(file = "file-path-to-tree.tre")
#' astral.data = astralPlane(astral.tree = your.tree,
#'                           outgroups = c("species_one", "species_two"),
#'                           tip.length = 1)
#'
#' @export

dropboxDownload = function(sample.spreadsheet = NULL,
                           dropbox.directory = NULL,
                           dropbox.token = NULL,
                           out.directory = NULL,
                           overwrite = TRUE){
  
  ### Example usage
  # sample.spreadsheet = "/Users/chutter/Dropbox/Research/3_Sequence-Database/Raw-Reads-Published/Mitogenome_study.csv"
  # out.directory = "/Volumes/Armored/test"
  # dropbox.directory = "/Research/3_Sequence-Database/Raw-Reads"
  # overwrite = TRUE
  
  if (dir.exists(out.directory) == T & overwrite == TRUE){
    system(paste("rm -r ", out.directory))
    dir.create(out.directory)
  }
  
  if (dir.exists(out.directory) == F){ dir.create(out.directory) }
  
  all.reads = rdrop2::drop_dir(path = dropbox.directory,
                               recursive = TRUE)$path_display
  
  all.reads = all.reads[grep("fastq.gz$|fq.gz$", all.reads)]
  
  sample.data = read.csv(sample.spreadsheet)
  
  for (i in 1:nrow(sample.data)){
    
    sample.reads = all.reads[grep(as.character(sample.data$File_Name[i]), all.reads)]
    
    if (length(sample.reads) == 0) { 
      stop(paste0("Error: sample reads for ", sample.data$Final_Name[i], " not found!"))
    }
    
    if (length(sample.reads) != 2) { 
      stop(paste0("Error: too many sample reads for ", sample.data$Final_Name[i], " found!"))
    }
    
    #Save the read files with the new names in the new directory 
    rdrop2::drop_download(path = sample.reads[1], 
                          local_path = paste0(out.directory, "/", sample.data$Final_Name[i], "_R1_001.fastq.gz"),
                          overwrite = TRUE,
                          dtoken = dropbox.token)
    
    rdrop2::drop_download(path = sample.reads[2], 
                          local_path = paste0(out.directory, "/", sample.data$Final_Name[i], "_R2_001.fastq.gz"),
                          overwrite = TRUE,
                          dtoken = dropbox.token)
  }#end i loop
  
}#end function
