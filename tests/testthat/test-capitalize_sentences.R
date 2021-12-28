test_that("sentence capitalization for one line", {
  input = "how are you? thank you. i am fine. and you?"
  output = "How are you? Thank you. I am fine. And you?"
  expect_equal(capitalize_sentences(input), output)
})


test_that("sentence capitalization for multiple lines", {
  input = "# introduction


how are you? thank you. i am fine. and you?

i am fine too.
```{r}
L3 <- LETTERS[1:3]
fac <- sample(L3, 10, replace = TRUE)

d <- data.frame(x = 1, y = 1:10, fac = fac)
```

# method

```{r, fig.cap='never mind me.'}
# i am just a comment. my initial doesn't need to be capitalized. or do i?
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

```{r, fig.cap='Never mind me.'}
# i am just a comment. My initial doesn't need to be capitalized. Or do i?
1 + 1
```"
  expect_equal(capitalize_sentences(input), output)
})






