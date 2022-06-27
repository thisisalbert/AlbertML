qview <- function(df) {
  
  if (ncol(df) > 5 & nrow(df) > 5) {
    print(df[1:5, 1:5])
  }
  
  if (ncol(df) > 5 & nrow(df) < 5) {
    print(df[1:nrow(df), 1:5])
  }
  
  if (ncol(df) < 5 & nrow(df) > 5) {
    print(df[1:5, 1:ncol(df)])
  }
  
  if (ncol(df) < 5 & nrow(df) < 5) {
    print(df[1:nrow(df), 1:ncol(df)])
  }
  
}
