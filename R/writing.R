
x = "aea. aegaga. "
filename = "test.Rmd"
script = readLines(filename) # each line will be a string. grap strings with period in it. capitalize the first character, and first character 1 space after each period

#' Title
#'
#' @param script
#'
#' @return
#' @export
#'
#' @examples
capitalize_sentences = function(script){
  # script = "you are human. you really are. "
  num_str = length(script)
  for (iStr in 1: num_str){
    x = script[iStr]
    period_positions = str_locate_all(x, "\\.")[[1]]
    if(length(period_positions) != 0){
      num_sent = nrow(period_positions)

      str_sub(x, 1, 1) = toupper(str_sub(x, 1, 1))
      for(iSent in 1: (num_sent-1)){
        str_sub(x, period_positions[iSent, "start"]+2, period_positions[iSent, "end"]+2) = toupper(str_sub(x, period_positions[iSent, "start"]+2, period_positions[iSent, "end"]+2))
      }
      script[iStr] = x
    }
  }
  return(script)
}

#' Title
#'
#' @param script
#'
#' @return
#' @export
#'
#' @examples
capitalize_headings = function(script){
  # script = "### introduction"
  num_str = length(script)
  for (iStr in 1: num_str){
    x = script[iStr]
    pond_positions = str_locate_all(x, "#")[[1]]
    if(length(pond_positions) != 0){
      num_pond = nrow(pond_positions)

      str_sub(x, pond_positions[num_pond, "start"]+2, pond_positions[num_pond, "end"]+2) = toupper(str_sub(x, pond_positions[num_pond, "start"]+2, pond_positions[num_pond, "end"]+2))
      script[iStr] = x
    }
  }
  return(script)
}
fileConn = file(filename)
writeLines(script, fileConn)
close(fileConn)
