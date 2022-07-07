makeFileName <- function(outDir = outDir, file_name) {
  if (exists("outDir")) {
    paste0(outDir, paste0(format(Sys.time(), "%y_%m_%d_"), file_name))
  } else {
    file.path(getwd(), paste0(format(Sys.time(), "%y_%m_%d_"), file_name))
  }
}
