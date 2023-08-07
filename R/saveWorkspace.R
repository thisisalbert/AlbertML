saveWorkspace <- 
  function(workdir = outDir, nameImage = "workspace", saveEnv = TRUE, saveInfo = TRUE) {
    
    if (exists("workdir") == TRUE) {
      destination = workdir
    } else {
      destination = getwd()
    }
    
    if (saveEnv) {
      save.image(
        file.path(destination, paste0(format(Sys.Date(), "%y_%m_%d_"), nameImage, ".RData"))
      )
    }
    
    if (saveInfo) {
      writeLines(
        text = capture.output(sessionInfo()), 
        con = file.path(destination, format(Sys.Date(), "%y_%m_%d_sessionInfo.txt"))
      )
    }
    
    message("\nWorkspace has been saved!\n")  
    
  }
