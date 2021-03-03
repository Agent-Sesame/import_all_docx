docx_import <- function() {

     # Install readtext package - this next line needs to be run once, then 
     # remove this next line from this function
     
     # install.packages("readtext")

     # Load required packages
     
     library(readtext)

     # Set working directory
     
     setwd(paste(getwd(), "/data/", sep = ""))
     
     # Create list of files to import
     
     vector_files <- list.files()
     
     # Read in Word data (.docx)
     
     df_output <- readtext(vector_files)
     
     # remove \\n new line elements, replace with semicolon for splitting. the 
     # new line character was not playing nicely with other functions and 
     # features in r. replacing new line indicator with a semi-colon allowed 
     # strsplit on line 37 to work.
     
     df_output <- as.data.frame(gsub("\\n", ";", df_output[2]))
     
     # rename df_output column name to 'content'
     
     colnames(df_output) <- c("content")
     
     # reshape df_output, splitting content on semi-colon
     
     df_output_reshaped <- strsplit(df_output$content, ";")
     
     # de-listify df_output_reshaped
     
     vector_unlist <- unlist(df_output_reshaped)
     
     # transform vector_unlist into a dataframe
     
     df_output_clean <- as.data.frame(vector_unlist)
     
     # create dataframe of document id 
     
     df_docid <- as.data.frame(rep(vector_files, 
                                   times = (length(vector_unlist))))
     
     # create final output df
     
     df_final <- cbind(df_docid, df_output_clean)
     
     # clean up df_final column names
     
     colnames(df_final) <- c("doc_id", "content")
     
}