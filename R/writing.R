#' when called by formalize_writing, replace shorthands with full spelling. when called by modify_code, replace whatever it is needed, here are some occasions: modify psychopy script used for a single list for exp combining all lists.
#'
#' @param target character
#'
#' @param dict_filename character
#'
#' @return character
#' @export
replace_based_on_dict = function(script){
  # efficientize:: replace_based_on_dict("/Users/xzfang/Github/ideal_adapter/ideal_adapter_exp2_List_All/interface_exp2.py", 'dict_psychopy_interface')
  script = readChar(target_filename, file.info(target_filename)$size)
  data(list = c(dict_filename)) # The ability to specify a dataset by name (without quotes) is NOT a convenience. if i do data(dict_filename) i get In data(dict_filename) : data set ‘dict_filename’ not found
  eval(parse(text = paste0(c("df_dict =", dict_filename))))
  # files ending ‘.csv’ or ‘.CSV’ are read using read.table(..., header = TRUE, sep = ";", as.is=FALSE), and also result in a data frame.
  # https://kbroman.org/pkg_primer/pages/data.html
  # https://www.davekleinschmidt.com/r-packages/#fn1
  # todo stuck at https://stackoverflow.com/questions/30148254/r-read-table-with-quotation-marks will probably have to go kleinschmidt way



  # print(dict_psychopy_interface)
  # print(dict_writing)

  print(df_dict)
  # df_dict = read.csv(dict_filename)
  for(iRow in 1:nrow(df_dict)){
    print(df_dict[iRow,"old"])
    script = stringr::str_replace_all(script, df_dict[iRow,"old"], df_dict[iRow, "new"])
  }

  return(script)
  fileConn = file(target_filename)
  writeLines(script, fileConn)
  close(fileConn)
}


exempt_rchunk = function(script){
  exempt_position = c()


  if(stringr::str_detect(script, "```")){
    rchunk_start_position = stringr::str_locate_all(script, "```\\{")[[1]][, "start"]
    # subtract second set from first set
    rchunk_end_position =  setdiff(stringr::str_locate_all(script, "```")[[1]][, "start"], rchunk_start_position)

    if(length(rchunk_start_position) != length(rchunk_end_position)){
      stop("you got ``` in your comments, remove those, search for # ``` may help")
    }

    # if more than one chunk, will get In addition: Warning message:
    # In if (!is.na(rchunk_start_position)) { :
    # the condition has length > 1 and only the first element will be used
    if(sum(!is.na(rchunk_start_position))>0){
      exempt_position = c()
      num_rchunk = length(rchunk_start_position)
      for(iR in 1:num_rchunk){
        exempt_position = c(exempt_position, rchunk_start_position[iR]:rchunk_end_position[iR])
      }
    }
    # print(character_after_new_line_position)

  }
  return(exempt_position)
}

exempt_yaml_header = function(script){
  if(stringr::str_detect(script, "---")){

    yaml_chunk_postions = stringr::str_locate_all(script, "---")[[1]]
    exempt_position = yaml_chunk_postions[1, 'start']: yaml_chunk_postions[2, 'end']

  } else{
    exempt_position = c()

  }
}
#' capitalize the first letter of the first word in each sentence, by finding ". ", "! ", "'" in text and capitalize the first character following them, by finding "\n" in text exempting those in rchunk and in yaml header and capitalize the first character following them, and by handing a few special occasions: the very first character. This doesn't take of after """. so try to use single quote
#'
#' @param script character
#'
#' @return character
#' @export
#'
#' @examples
#' capitalize_sentences("how are you? thank you. i am fine. and you?")
capitalize_sentences = function(script){


  # capitalize the first character
  stringr::str_sub(script, 1, 1) = toupper(stringr::str_sub(script, 1, 1))

  # finding ". ", "! ", "'" in text and capitalize the first character following them

  period_position = rbind(stringr::str_locate_all(script, "\\. ")[[1]], stringr::str_locate_all(script, "\\? ")[[1]], stringr::str_locate_all(script, "\\' ")[[1]])

  num_sent = nrow(period_position)


  if(num_sent != 0){

    for(iSent in 1: num_sent){
      stringr::str_sub(script, period_position[iSent, "start"]+2, period_position[iSent, "end"]+1) = toupper(stringr::str_sub(script, period_position[iSent, "start"]+2, period_position[iSent, "end"]+1))
    }
  }

  # capitalize every character following a newline except those in rchunk
  # those in yaml header


  character_after_new_line_position = stringr::str_locate_all(script, "\n")[[1]][, "start"] + 1 #\n count as one character
  exempt_position = c(exempt_rchunk(script), exempt_yaml_header(script))



  # those in latex expression
  if(stringr::str_detect(script, "\\$\\$")){
    latex_position = stringr::str_locate_all(script, "\\$\\$")[[1]]
    num_marks = nrow(latex_position)
    if(num_marks %% 2 != 0){
      stop("you got $$ in your comments, remove those, search for # $$ may help")
    }
    latex_start_position =  stringr::str_locate_all(script, "\\$\\$")[[1]][seq(1, num_marks, 2), "start"]
    latex_end_position =  stringr::str_locate_all(script, "\\$\\$")[[1]][seq(2, num_marks, 2), "start"]

    if(sum(!is.na(latex_start_position))>0){
      num_latex = length(latex_start_position)
      for(iR in 1:num_latex){
        exempt_position = c(exempt_position, latex_start_position[iR]:latex_end_position[iR])
      }
    }
  }

  character_after_new_line_position = character_after_new_line_position[!(character_after_new_line_position %in% exempt_position)]


  # print(character_after_new_line_position)
  if(length(character_after_new_line_position ) != 0){
    num_sent = length(character_after_new_line_position )

    for(iSent in 1: num_sent){
      stringr::str_sub(script, character_after_new_line_position [iSent], character_after_new_line_position [iSent]) = toupper(stringr::str_sub(script, character_after_new_line_position [iSent], character_after_new_line_position [iSent]))
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

  character_after_pound_position = stringr::str_locate_all(script, "# ")[[1]][, "end"] + 1

  exempt_position = c(exempt_rchunk(script), exempt_yaml_header(script))

  character_after_pound_position = character_after_pound_position[!(character_after_pound_position %in% exempt_position)]


  if(length(character_after_pound_position) != 0){
    num_pound = length(character_after_pound_position)
    for(iPound in 1: num_pound){
      stringr::str_sub(script, character_after_pound_position[iPound], character_after_pound_position[iPound]) = toupper(stringr::str_sub(script, character_after_pound_position[iPound], character_after_pound_position[iPound]))

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



  script = readChar(filename, file.info(filename)$size)
  script = script %>%
    capitalize_headings() %>%
    capitalize_sentences()

  fileConn = file(output_filename)
  writeLines(script, fileConn)
  close(fileConn)
}


