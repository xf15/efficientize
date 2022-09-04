
<!-- README.md is generated from README.Rmd. Please edit that file -->

# efficientize

Efficientize writing and programming

## what it does

### Functions

in writing\_help.R \* `formalize_writing()` applies \*
`replace_based_on_dict()` to \* replace shorthands with full spellings
see
<https://github.com/xf15/efficientize/blob/main/data-raw/dict_writing.csv>
\* `capitalize_sentences()` to \* capitalize the first letter of the
first word in each sentence \* `capitalize_headings()` to \* capitalize
the first letter of the first word in rmd headings

You can supply the source file name only to change the source file
directly, e.g., `formalize_writing("informal_paper.Rmd")` or in addition
supply a destination file name to create a new file, e.g.,

    formalize_writing("informal_paper.Rmd", "formal_paper.Rmd")

for a demo see
[informal\_paper.Rmd](https://github.com/xf15/efficientize/tree/main/vignettes/informal_paper.Rmd)
see
[formal\_paper.Rmd](https://github.com/xf15/efficientize/tree/main/vignettes/formal_paper.Rmd)

in exp\_repo.R \* `add_papers()` \* export pdf of papers cited in
manuscript from zotero to /relevant\_papers of
<https://github.com/xf15/efficientize_exp_repo_template>

here is how i use all of these functions
<https://github.com/xf15/efficientize_exp_repo_template/blob/main/manuscript/render_manuscript.R>

### Templates

    usethis::use_rmarkdown_template(template_name = "scratch", template_description = "for exploration")
    usethis::use_rmarkdown_template(template_name = "slides", template_description = "template for slides")
    usethis::use_rmarkdown_template(template_name = "manuscript", template_description = "template for manuscript")

<https://github.com/xf15/efficientize/blob/main/inst/rmarkdown/templates/scratch/skeleton/skeleton.Rmd>

<https://github.com/xf15/efficientize/blob/main/inst/rmarkdown/templates/slides/skeleton/skeleton.Rmd>

<https://github.com/xf15/efficientize/blob/main/inst/rmarkdown/templates/manuscript/skeleton/skeleton.Rmd>

## how to use

### start

you want to define your own `dict` in `/data-raw`

you need to sync your own zotero bib to that in
`/inst/files_for_efficientize_exp_repo_template`

you need to `ln` your own bash files to those in
`/inst/files_for_unrelated_housekeeping`

so fork, clone

in your text editor, throughout this project, replace

    /Users/xzfang/Github/efficientize/

with your repo path

    devtools::install()

### update

as all those customized files mentioned above get updated, this pkg need
to be reinstalled

do

    (base) Xinzhus-MacBook-Pro:efficientize xzfang$ Rscript update.R

which

    rmarkdown::render("README.Rmd")

which

``` r
source('data-raw/create_dict.R')
#> ✔ Setting active project to '/Users/xzfang/Github/efficientize'
#> ✔ Saving 'dict_writing' to 'data/dict_writing.rda'
#> • Document your data (see 'https://r-pkgs.org/data.html')
#> ✔ Saving 'dict_psyexp' to 'data/dict_psyexp.rda'
#> • Document your data (see 'https://r-pkgs.org/data.html')

devtools::install()
#> Skipping 1 packages ahead of CRAN: highr
#>      checking for file ‘/Users/xzfang/Github/efficientize/DESCRIPTION’ ...  ✔  checking for file ‘/Users/xzfang/Github/efficientize/DESCRIPTION’
#>   ─  preparing ‘efficientize’: (689ms)
#>      checking DESCRIPTION meta-information ...  ✔  checking DESCRIPTION meta-information
#>   ─  checking for LF line-endings in source and make files and shell scripts
#>   ─  checking for empty or unneeded directories
#>   ─  building ‘efficientize_0.0.0.9000.tar.gz’
#>      
#> Running /Library/Frameworks/R.framework/Resources/bin/R CMD INSTALL \
#>   /var/folders/tl/nv1vx7q12q3gljk30t38d6s80000gn/T//RtmpkRUsra/efficientize_0.0.0.9000.tar.gz \
#>   --install-tests 
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
