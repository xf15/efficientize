
#' capitalize the first letter of the first word in each sentence
#'
#' @param script character
#'
#' @return character
#' @export
#'
#' @examples
#' capitalize_sentences("you are human. you really are. ")
capitalize_sentences = function(script){
  # script = "you are human. you really are. "
  num_str = length(script)
  for (iStr in 1: num_str){
    x = script[iStr]
    period_positions = stringr::str_locate_all(x, "\\.")[[1]]
    if(length(period_positions) != 0){
      num_sent = nrow(period_positions)

      stringr::str_sub(x, 1, 1) = toupper(stringr::str_sub(x, 1, 1))
      for(iSent in 1: (num_sent-1)){
        stringr::str_sub(x, period_positions[iSent, "start"]+2, period_positions[iSent, "end"]+2) = toupper(stringr::str_sub(x, period_positions[iSent, "start"]+2, period_positions[iSent, "end"]+2))
      }
      script[iStr] = x
    }
  }
  return(script)
}

#' capitalize the first letter of the first word in rmd headings
#'
#' @param script character
#'
#' @return character
#' @export
#'
#' @examples
#' capitalize_headings("### introduction")
capitalize_headings = function(script){
  # script = "### introduction"
  num_str = length(script)
  for (iStr in 1: num_str){
    x = script[iStr]
    pond_positions = stringr::str_locate_all(x, "#")[[1]]
    if(length(pond_positions) != 0){
      num_pond = nrow(pond_positions)

      stringr::str_sub(x, pond_positions[num_pond, "start"]+2, pond_positions[num_pond, "end"]+2) = toupper(stringr::str_sub(x, pond_positions[num_pond, "start"]+2, pond_positions[num_pond, "end"]+2))
      script[iStr] = x
    }
  }
  return(script)
}

#' apply functions capitalize_headings() and capitalize_sentences() to an existing rmd
#'
#' @param filename
#'
#' @return
#' @export
#'
#' @importFrom magrittr "%>%"
formalize_writing = function(filename, output_filename = filename){
  script = readLines(filename) # each line will be a string. grap strings with period in it. capitalize the first character, and first character 1 space after each period
  script = script %>%
    capitalize_headings() %>%
    capitalize_sentences()

  fileConn = file(output_filename)
  writeLines(script, fileConn)
  close(fileConn)
}


