test_that("capitalize first letter of first word in each sentence", {
  input = "you are human. you really are. "
  output = "You are human. You really are. "
  expect_equal(capitalize_sentences(input), output)
})
