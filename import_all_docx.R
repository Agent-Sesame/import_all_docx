import_all_docx <- function() {
     
     # Load required packages
     
     library(readtext)

     # set working directory to data directory for importing files
     
     setwd(paste(getwd(), "data", sep = "/"))
     
     # make vector_files list of file names in 'data' sub-directory
     
     vector_files <- list.files()
     
     # automated rbind operation on an lapply of 'readtext' function on list
     # of files names contained in vector_files.
     
     df_output <- do.call("rbind", lapply(vector_files, readtext))
     
     # subset df_output to extract data.frame element created by readtext
     
     df_output <- as.data.frame(df_output[[2]])
     
     # split text in df_output[[2]] by the new line \\n character string
     
     df_output <- strsplit(df_output$`df_output[[2]]`, "\\n")
     
     # unlist the resulting df_output list into character vector
     
     vector_output_text <- unlist(df_output)
     
     # calculate number of lines in the readtext data based on vector length
     
     vector_rep_filename <- as.vector(unlist(lapply(df_output, length)))
     
     # repeat vector_files filename number of times as per vector_rep_filename
     
     vector_filenames <- rep(vector_files, vector_rep_filename)
     
     # transform the 2 character vectors filenames and output_text into data
     # frames and bind together, thereby joining the original file name with 
     # the associated imported text. allows for quality assurance of the import 
     # process
     
     df_final <- cbind(as.data.frame(vector_filenames),
                       as.data.frame(vector_output_text))
     
     # change working directory to one level up directory tree
     
     setwd('..')
     
     # change working directory to output sub-directory for saving csv output
     
     setwd(paste(getwd(), "output", sep = "/"))
     
     # save word document text data in csv form in output directory.
     
     write.csv(df_final, "all docx data in table format.csv")
     
     # return working directory to one level up directory tree
     
     setwd('..')
     
}