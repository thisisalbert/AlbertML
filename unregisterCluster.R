unregisterCluster <- function() {
  if (any(str_detect(ls(), "cl")) == TRUE) {
    stopCluster(cl)
    env <- foreach:::.foreachGlobals
    rm(list = ls(name = env), pos = env)
    gc(verbose = FALSE)
  } else {
  warning("Caution: No cluster object is defined in the current environment!")
  }
}
