#' replace strings referring to "dictionaries"
#'
#' duh
#'
#' i use it in two scenarios. for writing
#' ,
#' replace shorthands with full spellings see https://github.com/xf15/efficientize/blob/main/data-raw/dict_writing.csv
#' .
#' for code
#' ,
#' modify psyexp script used for a single list to be used as script for task combining all lists see https://github.com/xf15/efficientize/blob/main/data-raw/dict_psyexp.csv
#' .
#' if you want to use this feature, you should fork my repo, replace my csv with your own, and install your repo, don't send me pull request on this
#'
#'
#'
#' @param script character
#'
#' @return character
#'
#' @examples
#' replace_based_on_dict("in exp1", 'dict_writing.rda')
#'
#' @export
replace_based_on_dict = function(script, dict_filenames = c('dict_writing.rda')){
  df_dict_names = stringr::str_sub(dict_filenames, 1, -5)
  num_dict = length(dict_filenames)


  # end up not using
  # https://rdrr.io/r/utils/data.html
  # because the parameters it passes to read.table doesn't include quote="\"" to exempt single quote, cannot handle single quote in my code csv. others annoying things are it uses ; not , as sep. it convert string to factors
  # https://developer.r-project.org/Blog/public/2020/02/16/stringsasfactors/
  data(list = c(df_dict_names)) # The ability to specify a dataset by name (without quotes) is NOT a convenience. if i do data(dict_filename) i get warning message In data(dict_filename) : data set ‘dict_filename’ not found

  # use exempt_rchunk to find all text sections, loop through all text sections to str_replace_all
  if(stringr::str_detect(script, "```")){
    rchunk_start_position = stringr::str_locate_all(script, "```\\{")[[1]][, "start"]
    # subtract second set from first set
    rchunk_end_position =  setdiff(stringr::str_locate_all(script, "```")[[1]][, "start"], rchunk_start_position)

    if(length(rchunk_start_position) != length(rchunk_end_position)){
      stop("you got ``` in your comments, remove those, search for # ``` may help")
    }


    text_section_start_position = c(1, rchunk_end_position)
    text_section_end_position = c(rchunk_start_position, nchar(script))
    num_text_section = length(text_section_start_position)
    for (iSect in c(1:num_text_section)){
      cur_start = text_section_start_position[iSect]
      cur_end = text_section_end_position[iSect]
      for(iDict in c(1: num_dict)){
        eval(parse(text = paste0(c("df_dict =", df_dict_names[iDict]))))
        for(iRow in 1:nrow(df_dict)){ # to make sure to replace words only not some part of words, all replaced string should follow or is followed by a space
          stringr::str_sub(script, cur_start, cur_end) = stringr::str_replace_all(stringr::str_sub(script, cur_start, cur_end), paste0(' ', df_dict[iRow,"old"]), paste0(' ',  df_dict[iRow, "new"]))
          stringr::str_sub(script, cur_start, cur_end) = stringr::str_replace_all(stringr::str_sub(script, cur_start, cur_end), paste0(df_dict[iRow,"old"], ' '), paste0( df_dict[iRow, "new"], ' '))
        }
      }

    }
  }


  return(script)
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


    exempt_position = c()
    num_rchunk = length(rchunk_start_position)
    for(iR in 1:num_rchunk){
      exempt_position = c(exempt_position, rchunk_start_position[iR]:rchunk_end_position[iR])
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



#' capitalize the first letter of the first word in each sentence
#'
#' @param script character
#'
#' @return character
#'
#' @examples
#' capitalize_sentences("how are you? thank you. i am fine. and you?")
#'
#' @export
capitalize_sentences = function(script){


  # capitalize the very first character of entire doc (innocuous to rmd yaml header)
  stringr::str_sub(script, 1, 1) = toupper(stringr::str_sub(script, 1, 1))

  # find position of rchunk and yaml heeader. they will be exempted

  exempt_position = c(exempt_rchunk(script), exempt_yaml_header(script))


  # exempt those in latex expression
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



  # find ". ", "! "in text and capitalize the first character following them

  period_position = c(stringr::str_locate_all(script, "\\. ")[[1]][, "end"] + 1, stringr::str_locate_all(script, "\\? ")[[1]][, "end"] + 1, stringr::str_locate_all(script, "\\' ")[[1]][, "end"] + 1)


  # it's ok, see the space i included behind ? and .
  # period_position = period_position[!(period_position %in% exempt_position)]




  num_sent = length(period_position)


  if(num_sent != 0){

    for(iSent in 1: num_sent){
      stringr::str_sub(script, period_position [iSent], period_position [iSent]) = toupper(stringr::str_sub(script, period_position [iSent], period_position [iSent]))
    }
  }




  # find "\n" in text and capitalize the first character following them



  character_after_new_line_position = stringr::str_locate_all(script, "\n")[[1]][, "end"] + 1 #\n count as one character


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
#'
#' @examples
#' capitalize_headings("### introduction")
#'
#' @export
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

#' apply functions capitalize_headings(), capitalize_sentences(), replace_based_on_dict() to an existing rmd
#'
#' @param filename
#'
#'
#' @importFrom magrittr "%>%"
#'
#' @export
formalize_writing = function(filename, output_filename = filename){

  script = readChar(filename, file.info(filename)$size)
  script = script %>%
    capitalize_headings() %>%
    capitalize_sentences() %>%
    replace_based_on_dict()

  fileConn = file(output_filename)
  writeLines(script, fileConn)
  close(fileConn)
}


