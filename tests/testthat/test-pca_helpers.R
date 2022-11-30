test_that("pc_name() gives the correct pc names given a pc number", {
  expect_equal(pc_name(2), 'PC2')
})


test_that("pc_names() gives the correct vector of pcs given a pc number", {
  expect_equal(pc_names(3), c('PC1', 'PC2', 'PC3'))
})


test_that("variance_proportion() gives the variance of each PC given a dataframe", {
  test_data = data.frame(PC1 = 1:4, PC2 = c(3,8,9,7), PC3 = c(3,0,2,3))
  tot_var = var(test_data$PC1) + var(test_data$PC2) + var(test_data$PC3)
  expect_equal(variance_proportion(test_data), c(var(test_data$PC1), var(test_data$PC2), var(test_data$PC3)) * 100 / tot_var)
})

test_that("cum_variance_proportion() gives the variance of each PC given a dataframe", {
  test_data = data.frame(PC1 = 1:4, PC2 = c(3,8,9,7), PC3 = c(3,0,2,3))
  var1 = var(test_data$PC1); var2 = var(test_data$PC2); var3 = var(test_data$PC3)
  tot_var = var1 + var2 + var3
  expect_equal(cum_variance_proportion(test_data), c(var1, var1+var2, var1 + var2 + var3) * 100 / tot_var)
})
