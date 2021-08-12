test_that("capitalize first letter of first word in headings", {
  input = "### introduction"
  output = "### Introduction"
  expect_equal(capitalize_headings(input), output)
})

test_that("capitalize first letter of first word in each sentence", {
  input = "---
title: 'Talker-general vs. Talker-specific Acoustic-phonetic Mappings during Speech Comprehension'
output:
  # html_document:
  # pdf_document:
  bookdown::pdf_document2:
    toc: no
    latex_engine: xelatex
    number_sections: true
bibliography: zotero.bib
csl: apa-6th-edition.csl
---"
  output = "---
title: 'Talker-general vs. Talker-specific Acoustic-phonetic Mappings during Speech Comprehension'
output:
  # html_document:
  # pdf_document:
  bookdown::pdf_document2:
    toc: no
    latex_engine: xelatex
    number_sections: true
bibliography: zotero.bib
csl: apa-6th-edition.csl
---"
  expect_equal(capitalize_headings(input), output)
})


test_that("capitalize first letter of first word in each sentence", {
  input = "---
title: 'Talker-general vs. Talker-specific Acoustic-phonetic Mappings during Speech Comprehension'
output:
  # html_document:
  # pdf_document:
  bookdown::pdf_document2:
    toc: no
    latex_engine: xelatex
    number_sections: true
bibliography: zotero.bib
csl: apa-6th-edition.csl
---"
  output = "---
title: 'Talker-general vs. Talker-specific Acoustic-phonetic Mappings during Speech Comprehension'
output:
  # html_document:
  # pdf_document:
  bookdown::pdf_document2:
    toc: no
    latex_engine: xelatex
    number_sections: true
bibliography: zotero.bib
csl: apa-6th-edition.csl
---"
  expect_equal(capitalize_headings(input), output)
})


test_that("capitalize first letter of first word in each sentence", {
  input = "```{r}
# i am just a comment. my initial doesn't need to be capitalized. or do i?
1 + 1
```"
  output = "```{r}
# i am just a comment. my initial doesn't need to be capitalized. or do i?
1 + 1
```"
  expect_equal(capitalize_headings(input), output)
})
