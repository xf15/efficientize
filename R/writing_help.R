replace_in_all_text_for_all_entries_in_all_dicts = function(cur_text, names_of_tDict) {
  num_dict = length(names_of_tDict)


  # end up not using https://rdrr.io/r/utils/data.html because the parameters
  # it passes to read.table doesn't include quote='\'' to exempt single quote,
  # cannot handle single quote in my code csv. others annoying things are it
  # uses ; not , as sep. it convert string to factors
  # https://developer.r-project.org/Blog/public/2020/02/16/stringsasfactors/
  data(list = c(names_of_tDict))  # The ability to specify a dataset by name (without quotes) is NOT a convenience. if i do data(dict_filename) i get warning message In data(dict_filename) : data set \342\200\230dict_filename\342\200\231 not found


  cur_text = stringr::str_replace_all(cur_text, ' i ', ' I ')

  for (iDict in c(1:num_dict)) {
    eval(parse(text = paste0(c("df_dict =", names_of_tDict[iDict]))))
    # print(df_dict)
    for (iRow in 1:nrow(df_dict)) {

      # replace only if shorthand follows space, so that "rt" in "short" not replaced. this won't handle when having a shorthand like "ab", first avoid them, if cannot, in the dict, do " ab" instead of "ab". fix manually when sentence starts with "rt".
      cur_text = stringr::str_replace_all(cur_text, paste0(" ", df_dict[iRow, "old"]), paste0(" ",
                                                                                              df_dict[iRow, "new"]))

      # cur_text = stringr::str_replace_all(cur_text, paste0(df_dict[iRow, "old"], " "), paste0(
      #                                                                                        df_dict[iRow, "new"], " "))
    }
  }

  return(cur_text)
}


#' replace strings referring to 'dictionaries'
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
#' replace_in_selective_text_for_all_entries_in_all_dicts('in exp1', 'dict_writing.rda')
#'
#' @export
replace_in_selective_text_for_all_entries_in_all_dicts = function(script, dict_filenames = c("dict_writing.rda", "dict_my_writing.rda")) {
  names_of_tDict = stringr::str_sub(dict_filenames, 1, -5)
  print(names_of_tDict)


  # if rmd
  # to find all text sections, loop through all text sections
  # to str_replace_all
  # else, simply str_replace_all
  if (stringr::str_detect(script, "```")) {
    rchunk_start_position = stringr::str_locate_all(script, "```\\{")[[1]][,
      "start"]
    # subtract second set from first set
    rchunk_end_position = setdiff(stringr::str_locate_all(script, "```")[[1]][,
      "start"], rchunk_start_position)

    if (length(rchunk_start_position) != length(rchunk_end_position)) {
      stop("you got ``` in your comments, remove those, search for # ``` may help")
    }


    text_section_start_position = c(1, rchunk_end_position)
    text_section_end_position = c(rchunk_start_position, nchar(script))
    num_text_section = length(text_section_start_position)
    # print(num_text_section)

    for (iSect in c(1:num_text_section)) {
      cur_start = text_section_start_position[iSect]
      cur_end = text_section_end_position[iSect]
      cur_text = stringr::str_sub(script, cur_start, cur_end)
      stringr::str_sub(script, cur_start, cur_end) = replace_in_all_text_for_all_entries_in_all_dicts(cur_text, names_of_tDict)
      # print(cur_text)
    }
  } else{
    script = replace_in_all_text_for_all_entries_in_all_dicts(script, names_of_tDict)
  }


  return(script)
}



exempt_rchunk = function(script) {
  exempt_position = c()


  if (stringr::str_detect(script, "```")) {
    rchunk_start_position = stringr::str_locate_all(script, "```\\{")[[1]][,
      "start"]
    # subtract second set from first set
    rchunk_end_position = setdiff(stringr::str_locate_all(script, "```")[[1]][,
      "start"], rchunk_start_position)

    if (length(rchunk_start_position) != length(rchunk_end_position)) {
      stop("you got ``` in your comments, remove those, search for # ``` may help")
    }


    exempt_position = c()
    num_rchunk = length(rchunk_start_position)
    for (iR in 1:num_rchunk) {
      exempt_position = c(exempt_position, rchunk_start_position[iR]:rchunk_end_position[iR])
    }

    # print(character_after_new_line_position)

  }
  return(exempt_position)
}

exempt_yaml_header = function(script) {
  if (stringr::str_detect(script, "---")) {

    yaml_chunk_postions = stringr::str_locate_all(script, "---")[[1]]
    exempt_position = yaml_chunk_postions[1, "start"]:yaml_chunk_postions[2,
      "end"]

  } else {
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
#' capitalize_sentences('how are you? thank you. i am fine. and you?')
#'
#' @export
capitalize_sentences = function(script) {


  # capitalize the very first character of entire doc (innocuous to rmd yaml
  # header)
  stringr::str_sub(script, 1, 1) = toupper(stringr::str_sub(script, 1, 1))

  # find position of rchunk and yaml heeader. they will be exempted

  exempt_position = c(exempt_rchunk(script), exempt_yaml_header(script))


  # exempt those in latex expression
  if (stringr::str_detect(script, "\\$\\$")) {
    latex_position = stringr::str_locate_all(script, "\\$\\$")[[1]]
    num_marks = nrow(latex_position)
    if (num_marks%%2 != 0) {
      stop("you got $$ in your comments, remove those, search for # $$ may help")
    }
    latex_start_position = stringr::str_locate_all(script, "\\$\\$")[[1]][seq(1,
      num_marks, 2), "start"]
    latex_end_position = stringr::str_locate_all(script, "\\$\\$")[[1]][seq(2,
      num_marks, 2), "start"]

    if (sum(!is.na(latex_start_position)) > 0) {
      num_latex = length(latex_start_position)
      for (iR in 1:num_latex) {
        exempt_position = c(exempt_position, latex_start_position[iR]:latex_end_position[iR])
      }
    }
  }



  # find '. ', '? ', '! 'in text and capitalize the first character following them

  period_position = c(stringr::str_locate_all(script, "\\. ")[[1]][, "end"] + 1,
    stringr::str_locate_all(script, "\\? ")[[1]][, "end"] + 1, stringr::str_locate_all(script,
      "\\! ")[[1]][, "end"] + 1)


  # do not need exempt for this because none of these appear in code, always space after . and !
  # period_position = period_position[!(period_position %in% exempt_position)]


  num_sent = length(period_position)


  if (num_sent != 0) {

    for (iSent in 1:num_sent) {
      stringr::str_sub(script, period_position[iSent], period_position[iSent]) = toupper(stringr::str_sub(script,
        period_position[iSent], period_position[iSent]))
    }
  }




  # find '\n' in text and capitalize the first character following them

  character_after_new_line_position = stringr::str_locate_all(script, "\n")[[1]][,
    "end"] + 1  #\n count as one character


  character_after_new_line_position = character_after_new_line_position[!(character_after_new_line_position %in%
    exempt_position)]


  # print(character_after_new_line_position)
  if (length(character_after_new_line_position) != 0) {
    num_sent = length(character_after_new_line_position)

    for (iSent in 1:num_sent) {
      stringr::str_sub(script, character_after_new_line_position[iSent], character_after_new_line_position[iSent]) = toupper(stringr::str_sub(script,
        character_after_new_line_position[iSent], character_after_new_line_position[iSent]))
    }
  }

  return(script)
}

#' replace underscore with space in all sentences
#'
#' @param script character
#'
#' @return character
#'
#' @examples
#' replace_underscore_with_space('noisy_channel_theory[@levy_noisychannel_2008; @gibson_rational_2013]')
#'
#' @export
replace_underscore_with_space = function(script){
  # find position of rchunk and yaml heeader. they will be exempted

  exempt_position = c(exempt_rchunk(script), exempt_yaml_header(script))


  # exempt those in chunk latex expression
  if (stringr::str_detect(script, "\\$\\$")) {
    latex_position = stringr::str_locate_all(script, "\\$\\$")[[1]]
    num_marks = nrow(latex_position)
    if (num_marks%%2 != 0) {
      stop("you got $$ in your comments, remove those, search for # $$ may help")
    }
    latex_start_position = stringr::str_locate_all(script, "\\$\\$")[[1]][seq(1,
                                                                              num_marks, 2), "start"]
    latex_end_position = stringr::str_locate_all(script, "\\$\\$")[[1]][seq(2,
                                                                            num_marks, 2), "start"]

    if (sum(!is.na(latex_start_position)) > 0) {
      num_latex = length(latex_start_position)
      for (iR in 1:num_latex) {
        exempt_position = c(exempt_position, latex_start_position[iR]:latex_end_position[iR])
      }
    }
  }

  # exempt those in inline chunk latex expression



  # exempt those in citation key
  first_underscore_in_citation_position = stringr::str_locate_all(script, "@[^_]*_")[[1]][,
                                                                                    "end"]

  second_underscore_in_citation_position = stringr::str_locate_all(script, "@[^_]*_[^_]*_")[[1]][,
                                                                                     "end"]

  # main
  underscore_position = stringr::str_locate_all(script, "_")[[1]][,
                                                                  "end"]
  exempt_position = c(exempt_position, first_underscore_in_citation_position, second_underscore_in_citation_position)

  underscore_position = underscore_position[!(underscore_position %in% exempt_position)]

  # print(underscore_position)
  if (length(underscore_position) != 0) {
    num_underscore = length(underscore_position)

    for (iUnderscore in 1:num_underscore) {
      stringr::str_sub(script, underscore_position[iUnderscore], underscore_position[iUnderscore]) = ' '
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
#' capitalize_headings('### introduction')
#'
#' @export
capitalize_headings = function(script) {

  character_after_pound_position = stringr::str_locate_all(script, "# ")[[1]][,
    "end"] + 1

  exempt_position = c(exempt_rchunk(script), exempt_yaml_header(script))

  character_after_pound_position = character_after_pound_position[!(character_after_pound_position %in%
    exempt_position)]


  if (length(character_after_pound_position) != 0) {
    num_pound = length(character_after_pound_position)
    for (iPound in 1:num_pound) {
      stringr::str_sub(script, character_after_pound_position[iPound], character_after_pound_position[iPound]) = toupper(stringr::str_sub(script,
        character_after_pound_position[iPound], character_after_pound_position[iPound]))

    }
  }

  return(script)
}

#' apply functions to an existing rmd
#'
#' @param filename
#'
#'
#' @importFrom magrittr '%>%'
#'
#' @export
formalize_writing = function(filename, output_filename = filename) {

  script = readChar(filename, file.info(filename)$size)
  script = script %>%
    replace_in_selective_text_for_all_entries_in_all_dicts() %>%
    capitalize_headings() %>%
    capitalize_sentences() %>%
    replace_underscore_with_space()

  fileConn = file(output_filename)
  writeLines(script, fileConn)
  close(fileConn)
}
