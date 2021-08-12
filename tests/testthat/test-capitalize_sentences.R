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

```{r}
# i am just a comment. My initial doesn't need to be capitalized. Or do i?
1 + 1
```"
  expect_equal(capitalize_sentences(input), output)
})






