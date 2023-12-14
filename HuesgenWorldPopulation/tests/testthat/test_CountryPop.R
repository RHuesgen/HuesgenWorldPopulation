#Test error message for input countries not in the dataset for
#CountryPopulation function.

test_that('Error message:Country is not in the dataset.', {
  expect_error(CountryPopulation(Mountain))
  expect_error(CountryPopulation(Arizona))
})
