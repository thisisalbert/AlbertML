makeFileName <- function(file_name, dir = outDir) {
  if (exists(deparse(substitute(dir)))) {
    file.path(dir, paste0(format(Sys.time(), "%y_%m_%d_"), file_name))
  } else {
    file.path(getwd(), paste0(format(Sys.time(), "%y_%m_%d_"), file_name))
  }
}
