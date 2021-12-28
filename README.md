
<!-- README.md is generated from README.Rmd. Please edit that file -->

# efficientize

<!-- badges: start -->
<!-- badges: end -->

Efficientize the Life of a Scientist

## Functions

-   writing\_help
    -   capitalize the first letter of the first word in each sentence
    -   capitalize the first letter of the first word in rmd headings
    -   replace shorthands with full spellings
-   todo
    -   dict\_psyexp.csv is there, not added to create\_dict.r, data.r

## Installation

I don’t expect this to ever be on CRAN

``` r
# install.packages("devtools")
devtools::install_github("xf15/efficientize")
```

## Documentation

<https://xf15.github.io/efficientize/index.html> <!-- ## Example -->

<!-- This is a basic example which shows you how to solve a common problem: -->
<!-- ```{r example} -->
<!-- library(efficientize) -->
<!-- ## basic example code -->
<!-- ``` -->
<!-- What is special about using `README.Rmd` instead of just `README.md`? You can include R chunks like so: -->
<!-- ```{r cars} -->
<!-- summary(cars) -->
<!-- ``` -->
<!-- You'll still need to render `README.Rmd` regularly, to keep `README.md` up-to-date. `devtools::build_readme()` is handy for this. You could also use GitHub Actions to re-render `README.Rmd` every time you push. An example workflow can be found here: <https://github.com/r-lib/actions/tree/master/examples>. -->
<!-- You can also embed plots, for example: -->
<!-- ```{r pressure, echo = FALSE} -->
<!-- plot(pressure) -->
<!-- ``` -->
<!-- In that case, don't forget to commit and push the resulting figure files, so they display on GitHub and CRAN. -->

## development note

consistent function documentation among readme, writing\_help.rmd,
writing\_help.r inside and outside function

consistent data documentation between data.r and writing\_help.r

str\_locate\_all gives named matrix, find dealt with as matrix searching
nrow, rest dealt with as vector

substr

<https://evoldyn.gitlab.io/evomics-2018/ref-sheets/R_strings.pdf>
