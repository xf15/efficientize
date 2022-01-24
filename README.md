
<!-- README.md is generated from README.Rmd. Please edit that file -->

# efficientize

Efficientize writing and programming

## Functions

-   `formalize_writing()` applies
    -   `capitalize_sentences()` to
        -   capitalize the first letter of the first word in each
            sentence
    -   `capitalize_headings()` to
        -   capitalize the first letter of the first word in rmd
            headings
    -   `replace_based_on_dict()` to
        -   replace shorthands with full spellings see
            <https://github.com/xf15/efficientize/blob/main/data-raw/dict_writing.csv>

You can supply the source file name only to change the source file
directly, e.g., `formalize_writing("informal_paper.Rmd")` or in addition
supply a destination file name to create a new file, e.g.,

    formalize_writing("informal_paper.Rmd", "formal_paper.Rmd")

see
[informal\_paper.Rmd](https://github.com/xf15/efficientize/tree/main/vignettes/informal_paper.Rmd)
see
[formal\_paper.Rmd](https://github.com/xf15/efficientize/tree/main/vignettes/formal_paper.Rmd)

-   `update_psychopy_script_for_multiple_lists()` applies
    -   `replace_based_on_dict()` to
        -   modify psyexp script used for a single list to be used as
            script for task combining all lists see
            <https://github.com/xf15/efficientize/blob/main/data-raw/dict_psyexp.csv>

## Templates

    usethis::use_rmarkdown_template(template_name = "default", template_description = "default template")
    usethis::use_rmarkdown_template(template_name = "slides", template_description = "template for slides")
    usethis::use_rmarkdown_template(template_name = "manuscript", template_description = "template for manuscript")

<https://github.com/xf15/efficientize/blob/main/inst/rmarkdown/templates/default/skeleton/skeleton.Rmd>

<https://github.com/xf15/efficientize/blob/main/inst/rmarkdown/templates/slides/skeleton/skeleton.Rmd>

<https://github.com/xf15/efficientize/blob/main/inst/rmarkdown/templates/manuscript/skeleton/skeleton.Rmd>

<https://bookdown.org/yihui/rmarkdown/template-structure.html>

## Installation

I don’t expect this to ever be on CRAN

``` r
# install.packages("devtools")
devtools::install_github("xf15/efficientize")
```

## Documentation

<https://xf15.github.io/efficientize/index.html>

## development note

copy first line of roxygen function comment for function here

the rest lines of roxygen comment should be copied from inline comments,
replacing \#’ with \# otherwise get all code recognized as roxygen get
@export may only span a single line, supposed to be already fixed though
<https://github.com/r-lib/roxygen2/issues/737>

consistent function documentation among readme, writing\_help.rmd,
writing\_help.r inside and outside function

str\_locate\_all gives named matrix, find dealt with as matrix searching
nrow, rest dealt with as vector

substr

<https://evoldyn.gitlab.io/evomics-2018/ref-sheets/R_strings.pdf>
