unregisterCluster <- function() {
  
  if (any(stringr::str_detect(ls(), "cl"))) {
    parallel::stopCluster(cl)
    env <- foreach:::.foreachGlobals
    rm(list = ls(name = env), pos = env)
    gc()
  } else {
    warning("Caution: No cluster object is defined in the current environment!")
  }
  
}
