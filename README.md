
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

### dicts are updated when README.md is updated

``` r
source('data-raw/create_dict.R')
#> ✔ Setting active project to '/Users/xzfang/Github/efficientize'
#> ✔ Saving 'dict_writing' to 'data/dict_writing.rda'
#> • Document your data (see 'https://r-pkgs.org/data.html')
#> ✔ Saving 'dict_psyexp' to 'data/dict_psyexp.rda'
#> • Document your data (see 'https://r-pkgs.org/data.html')
```

## Templates

    usethis::use_rmarkdown_template(template_name = "scratch", template_description = "for exploration")
    usethis::use_rmarkdown_template(template_name = "slides", template_description = "template for slides")
    usethis::use_rmarkdown_template(template_name = "manuscript", template_description = "template for manuscript")

<https://github.com/xf15/efficientize/blob/main/inst/rmarkdown/templates/default/skeleton/skeleton.Rmd>

<https://github.com/xf15/efficientize/blob/main/inst/rmarkdown/templates/slides/skeleton/skeleton.Rmd>

<https://github.com/xf15/efficientize/blob/main/inst/rmarkdown/templates/manuscript/skeleton/skeleton.Rmd>

<https://bookdown.org/yihui/rmarkdown/template-structure.html>

## Installation

files in `/inst` with prefix my\_ need to be synced to your own files

so fork, clone

throughout this project, replace

    /Users/xzfang/Github/efficientize/

with your repo path

    devtools::install()

## update

this pkg needs to be updated as your own files are updated

``` r
devtools::install()
#> openssl   (2.0.1        -> 2.0.2       ) [CRAN]
#> Rcpp      (1.0.8.3      -> 1.0.9       ) [CRAN]
#> rlang     (1.0.2        -> 1.0.4       ) [CRAN]
#> generics  (0.1.2        -> 0.1.3       ) [CRAN]
#> stringi   (1.7.6        -> 1.7.8       ) [CRAN]
#> sass      (0.4.1        -> 0.4.2       ) [CRAN]
#> tinytex   (0.39         -> 0.40        ) [CRAN]
#> bslib     (0.3.1        -> 0.4.0       ) [CRAN]
#> rmarkdown (84dfc6674... -> d23e47901...) [GitHub]
#> Skipping 1 packages ahead of CRAN: highr
#> Installing 8 packages: openssl, Rcpp, rlang, generics, stringi, sass, tinytex, bslib
#> 
#>   There are binary versions available but the source versions are later:
#>       binary source needs_compilation
#> sass   0.4.1  0.4.2              TRUE
#> bslib  0.3.1  0.4.0             FALSE
#> 
#> 
#> The downloaded binary packages are in
#>  /var/folders/tl/nv1vx7q12q3gljk30t38d6s80000gn/T//RtmpeptQkM/downloaded_packages
#> installing the source packages 'sass', 'bslib'
#> Downloading GitHub repo rstudio/rmarkdown@HEAD
#> Skipping 1 packages ahead of CRAN: highr
#> * checking for file ‘/private/var/folders/tl/nv1vx7q12q3gljk30t38d6s80000gn/T/RtmpeptQkM/remotesf1b78dcb242/rstudio-rmarkdown-d23e479/DESCRIPTION’ ... OK
#> * preparing ‘rmarkdown’:
#> * checking DESCRIPTION meta-information ... OK
#> * checking for LF line-endings in source and make files and shell scripts
#> * checking for empty or unneeded directories
#> Removed empty directory ‘rmarkdown/tests/manual’
#> Removed empty directory ‘rmarkdown/tools’
#> * building ‘rmarkdown_2.14.3.tar.gz’
#> 
#> * checking for file ‘/Users/xzfang/Github/efficientize/DESCRIPTION’ ... OK
#> * preparing ‘efficientize’:
#> * checking DESCRIPTION meta-information ... OK
#> * checking for LF line-endings in source and make files and shell scripts
#> * checking for empty or unneeded directories
#> * building ‘efficientize_0.0.0.9000.tar.gz’
#> 
#> Running /Library/Frameworks/R.framework/Resources/bin/R CMD INSTALL \
#>   /var/folders/tl/nv1vx7q12q3gljk30t38d6s80000gn/T//RtmpeptQkM/efficientize_0.0.0.9000.tar.gz \
#>   --install-tests 
#> Loading required package: usethis
#> * installing to library ‘/Library/Frameworks/R.framework/Versions/4.1/Resources/library’
#> * installing *source* package ‘efficientize’ ...
#> ** using staged installation
#> ** R
#> ** data
#> *** moving datasets to lazyload DB
#> ** inst
#> ** tests
#> ** byte-compile and prepare package for lazy loading
#> ** help
#> *** installing help indices
#> ** building package indices
#> ** installing vignettes
#> ** testing if installed package can be loaded from temporary location
#> ** testing if installed package can be loaded from final location
#> ** testing if installed package keeps a record of temporary installation path
#> * DONE (efficientize)
```

## Documentation

<https://xf15.github.io/efficientize/>

## todo

efficientize::update\_psychopy\_script\_for\_multiple\_lists(“/Users/xzfang/Github/ideal\_adapter/interface\_exp2.psyexp”,
“/Users/xzfang/Github/ideal\_adapter/ideal\_adapter\_exp2\_List\_All/interface\_exp2\_list\_all.psyexp”)

only work when in project environment

go through all check warnings and note, rmd papers should be in inst/doc

why no <https://github.com/xf15/efficientize/blob/main/R/data.R> for
psyexp

## note

copy first line of roxygen function comment for function here

the rest lines of roxygen comment should be copied from inline comments,
replacing \#’ with \# otherwise get all code recognized as roxygen get
@export may only span a single line, supposed to be already fixed though
<https://github.com/r-lib/roxygen2/issues/737>

str\_locate\_all gives named matrix, find dealt with as matrix searching
nrow, rest dealt with as vector

substr

<https://evoldyn.gitlab.io/evomics-2018/ref-sheets/R_strings.pdf>
