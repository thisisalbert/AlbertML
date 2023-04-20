saveWorkspace <- function(workdir = outDir, saveEnv = TRUE, saveInfo = TRUE) {
  
  if (exists("workdir") == TRUE) {
    if (saveEnv) {
      save.image(
        file.path(workdir, format(Sys.time(), "%y_%m_%d_workspace.RData"))
      )
    }
    if (saveInfo) {
      writeLines(
        text = capture.output(sessionInfo()), 
        con = file.path(workdir, format(Sys.time(), "%y_%m_%d_sessionInfo.txt"))
      )
    }
  }
  
  if(exists("workdir") == FALSE) {
    if (saveEnv) {
      save.image(
        file.path(format(Sys.time(), "%y_%m_%d_workspace.RData"))
      )
    }
    if (saveInfo) {
      writeLines(
        text = capture.output(sessionInfo()), 
        con = file.path(format(Sys.time(), "%y_%m_%d_sessionInfo.txt"))
      )
    }
  }
  
  message("Workspace has been saved")
  
}
