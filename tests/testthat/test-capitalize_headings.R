test_that("capitalize first letter of first word in headings", {
  input = "### introduction"
  output = "### Introduction"
  expect_equal(capitalize_headings(input), output)
})
