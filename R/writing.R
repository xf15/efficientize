
#' capitalize the first letter of the first word in each sentence
#'
#' @param script character
#'
#' @return character
#' @export
#'
#' @examples
#' capitalize_sentences("how are you? thank you. i am fine. and you?")
capitalize_sentences = function(script){
  # script = "how are you? thank you. i am fine. and you?"
  #   script = "how are you? thank you. i am fine. and you?
  # ```{r}
  # L3 <- LETTERS[1:3]
  # fac <- sample(L3, 10, replace = TRUE)
  # d <- data.frame(x = 1, y = 1:10, fac = fac)
  # ```
  #
  # # method
  #
  # ```{r}
  # # i am just a comment. my initial doesn't really need to be capitalized but i don't mind if it happpens.
  # 1 + 1
  # ```"

  # capitalize the first character
  stringr::str_sub(script, 1, 1) = toupper(stringr::str_sub(script, 1, 1))

  # capitalize every character following a period and a space

  period_positions = rbind(stringr::str_locate_all(script, "\\. ")[[1]], stringr::str_locate_all(script, "\\? ")[[1]])

  num_sent = nrow(period_positions)


  if(num_sent != 0){

    for(iSent in 1: num_sent){
      stringr::str_sub(script, period_positions[iSent, "start"]+2, period_positions[iSent, "end"]+1) = toupper(stringr::str_sub(script, period_positions[iSent, "start"]+2, period_positions[iSent, "end"]+1))
    }
  }

  # capitalize every character following a newline except those in rchunk

  newline_position = stringr::str_locate_all(script, "\n")[[1]]

  if(stringr::str_detect(script, "```")){
    rchunk_start_positions = stringr::str_locate_all(script, "```\\{")[[1]][, "start"]
    # subtract second set from first set
    rchunk_end_positions =  setdiff(stringr::str_locate_all(script, "```")[[1]][, "start"], rchunk_start_positions)

    if(length(rchunk_start_positions) != length(rchunk_end_positions)){
      stop("you got ``` in your comments, remove those, search for # ``` may help")
    }

    # if moore than one chunk, will get In addition: Warning message:
    # In if (!is.na(rchunk_start_positions)) { :
    # the condition has length > 1 and only the first element will be used
    if(sum(!is.na(rchunk_start_positions))>0){
      exempt_positions = c()
      num_rchunk = length(rchunk_start_positions)
      for(iR in 1:num_rchunk){
        exempt_positions = c(exempt_positions, rchunk_start_positions[iR]:rchunk_end_positions[iR])
      }
    }
    # print(newline_position)

  }

  # those in yaml header
  if(stringr::str_detect(script, "---")){

    yaml_chunk_postions = stringr::str_locate_all(script, "---")[[1]]
    exempt_positions = c(exempt_positions, yaml_chunk_postions[1, 'start']: yaml_chunk_postions[2, 'end'])

  }
  # those in latex expression
  if(stringr::str_detect(script, "\\$\\$")){
    latex_positions = stringr::str_locate_all(script, "\\$\\$")[[1]]
    num_marks = nrow(latex_positions)
    if(num_marks %% 2 != 0){
      stop("you got $$ in your comments, remove those, search for # $$ may help")
    }
    latex_start_positions =  stringr::str_locate_all(script, "\\$\\$")[[1]][seq(1, num_marks, 2), "start"]
    latex_end_positions =  stringr::str_locate_all(script, "\\$\\$")[[1]][seq(2, num_marks, 2), "start"]

    if(sum(!is.na(latex_start_positions))>0){
      num_latex = length(latex_start_positions)
      for(iR in 1:num_latex){
        exempt_positions = c(exempt_positions, latex_start_positions[iR]:latex_end_positions[iR])
      }
    }
  }

  newline_position = newline_position[!(newline_position %in% exempt_positions)]


  # print(newline_position)
  if(length(newline_position ) != 0){
    num_sent = length(newline_position )

    for(iSent in 1: num_sent){
      stringr::str_sub(script, newline_position [iSent]+1, newline_position [iSent]+1) = toupper(stringr::str_sub(script, newline_position [iSent]+1, newline_position [iSent]+1))
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

  pound_positions = stringr::str_locate_all(script, "# ")[[1]]
  if(length(pound_positions) != 0){
    num_pound = nrow(pound_positions)
    for(iPound in 1: num_pound){
      stringr::str_sub(script, pound_positions[iPound, "start"]+2, pound_positions[iPound, "end"]+1) = toupper(stringr::str_sub(script, pound_positions[iPound, "start"]+2, pound_positions[iPound, "end"]+1))

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
  # filename = "vignettes/informal_paper.Rmd"
  # filename = "../cindy_writing/speech2.rmd"
  # formalize_writing("vignettes/informal_paper.Rmd", "vignettes/formal_paper.Rmd")


  script = readChar(filename, file.info(filename)$size)
  script = script %>%
    capitalize_headings() %>%
    capitalize_sentences()

  fileConn = file(output_filename)
  writeLines(script, fileConn)
  close(fileConn)
}


