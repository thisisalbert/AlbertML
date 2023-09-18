saveWorkspace <- 
  function(
    workdir = outDir, nameEnv = "workspace", nameLog = "sessionInfo", 
    saveEnv = TRUE, saveLog = TRUE
  ) {
    
    if (exists("workdir") == TRUE) {
      destination = workdir
    } else {
      destination = getwd()
    }
    
    if (saveEnv) {
      save.image(
        file.path(destination, paste0(format(Sys.Date(), "%y_%m_%d_"), nameEnv, ".RData"))
      )
    }
    
    if (saveLog) {
      writeLines(
        text = capture.output(sessionInfo()), 
        con = file.path(destination, format(Sys.Date(), "%y_%m_%d_", nameLog, ".txt"))
      )
    }
    
    if (saveEnv == TRUE & saveLog == TRUE) message("\nWorkspace & log have been saved!\n")
    if (saveEnv == TRUE & saveLog == FALSE) message("\nWokspace has been saved!\n")
    if (saveEnv == FALSE & saveLog == TRUE) message("\nLog has been saved!\n")
    
  }
