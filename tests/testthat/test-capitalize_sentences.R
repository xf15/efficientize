test_that("capitalize first letter of first word in each sentence", {
  input = "how are you? thank you. i am fine. and you?"
  output = "How are you? Thank you. I am fine. And you?"
  expect_equal(capitalize_sentences(input), output)
})


test_that("capitalize first letter of first word in each sentence", {
  input = "# introduction


how are you? thank you. i am fine. and you?

i am fine too.
```{r}
L3 <- LETTERS[1:3]
fac <- sample(L3, 10, replace = TRUE)

d <- data.frame(x = 1, y = 1:10, fac = fac)
```

# method

```{r}
# i am just a comment. my initial doesn't really need to be capitalized but i don't mind if it happens.
1 + 1
```"
  output = "# introduction


How are you? Thank you. I am fine. And you?

I am fine too.
```{r}
L3 <- LETTERS[1:3]
fac <- sample(L3, 10, replace = TRUE)

d <- data.frame(x = 1, y = 1:10, fac = fac)
```

# method

```{r}
# i am just a comment. My initial doesn't really need to be capitalized but i don't mind if it happens.
1 + 1
```"
  expect_equal(capitalize_sentences(input), output)
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
  expect_equal(capitalize_sentences(input), output)
})



