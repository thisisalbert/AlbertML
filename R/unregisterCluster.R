unregisterCluster <- function() {
  parallel::stopCluster(cl)
  env <- foreach:::.foreachGlobals
  rm(list = ls(name = env), pos = env)
  gc()
}
