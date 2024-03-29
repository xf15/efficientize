#' export pdf of papers cited in manuscript from zotero to /relevant_papers of https://github.com/xf15/efficientize_exp_repo_template
#'
#'
#' @examples
#' add_papers('second_year_paper.Rmd')
#' add_papers('version1.Rmd')
#'
#' @importFrom magrittr "%>%"
#'
#' @export
add_papers = function(manuscript_file_name){
  # remove all existing papers, that way papers later excluded get removed
  unlink(file.path('..', 'relevant_papers', '*'))

  script = readChar(manuscript_file_name, file.info(manuscript_file_name)$size)
  bibtext_citation_key = stringr::str_sub(
    unique(
      stringr::str_match_all(script, pattern='@\\w+_\\w+')[[1]] # returns list
    ),
    2, # remove @ at the beginning
    -1
  )

  # print(bibtext_citation_key)

  # tBib = bib2df::bib2df(file.path(.libPaths(), 'efficientize', 'files_for_efficientize_exp_repo_template', 'my_zotero.bib')) %>%
  tBib = bib2df::bib2df(system.file('files_for_efficientize_exp_repo_template', 'my_zotero.bib', package='efficientize')) %>%
    dplyr::filter(BIBTEXKEY %in% bibtext_citation_key) %>%
    dplyr::select(c('BIBTEXKEY', 'FILE'))
  # print(tBib)
  num_paper = nrow(tBib)
  # num_paper = 1
  for(iPaper in 1:num_paper){
    # "/Users/xzfang/Zotero/storage/8MMCHSDQ/Xie et al. - 2021 - Cross-talker generalization in the perception of n.pdf;/Users/xzfang/Zotero/storage/WYBI5ITL/Supplementary-information.pdf;/Users/xzfang/Zotero/storage/KIYF8YJ3/2021-71835-001.html"
    # print(stringr::str_split(tBib$FILE[iPaper], ';'))
    iPdf_paper = stringr::str_split(tBib$FILE[iPaper], ';')[[1]][1] # sometimes there are multiple files, seems that pdf goes before html
    eval(parse(text = paste0('file.copy(from="',
                             iPdf_paper,
                             '",
                             to="',
                             file.path('..', 'relevant_papers', paste0(tBib$BIBTEXKEY[iPaper], '.pdf')),
                             '")')))
  }

}
